import React, { useState, useEffect } from 'react';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import Heading from '@theme/Heading';
import clsx from 'clsx';
import styles from './index.module.css';

// === 🔊 DÙNG HOWLER TRỰC TIẾP – SỬA LỖI URL + KÍCH HOẠT SAU CLICK ===
import { Howl } from 'howler';

// 🔉 KHÔNG KHỞI TẠO ÂM THANH NGAY → CHỈ KHI CẦN
let beepSound: any = null;
let alertSound: any = null;
let errorSound: any = null;
let scanSound: any = null;
let startupSound: any = null;

// 🎯 Hàm tải và kích hoạt âm thanh (chỉ gọi sau khi người dùng click)
const loadSounds = () => {
  if (beepSound) return; // Đã tải rồi

  beepSound = new Howl({ src: ['https://assets.mixkit.co/sfx/preview/mixkit-software-interface-start-2574.mp3'], volume: 0.3 });
  alertSound = new Howl({ src: ['https://assets.mixkit.co/sfx/preview/mixkit-alarm-digital-clock-beep-989.mp3'], volume: 0.5 });
  errorSound = new Howl({ src: ['https://assets.mixkit.co/sfx/preview/mixkit-wrong-bleep-2044.mp3'], volume: 0.4 });
  scanSound = new Howl({ src: ['https://assets.mixkit.co/sfx/preview/mixkit-keyboard-click-1350.mp3'], volume: 0.2 });
  startupSound = new Howl({ src: ['https://assets.mixkit.co/sfx/preview/mixkit-unlock-game-notification-253.mp3'], volume: 0.4 });

  // 🔊 Phát nhẹ 1 âm thanh để "kích hoạt" Web Audio API
  beepSound.play();
  beepSound.stop();
};

// 🎵 Hàm phát âm thanh (chỉ khi đã tải)
const playBeep = () => { if (beepSound) beepSound.play(); };
const playAlert = () => { if (alertSound) alertSound.play(); };
const playError = () => { if (errorSound) errorSound.play(); };
const playScan = () => { if (scanSound) scanSound.play(); };
const playStartup = () => { if (startupSound) startupSound.play(); };

// === ⏰ Đồng hồ số ===
function DigitalClock() {
  const [now, setNow] = React.useState(new Date());
  React.useEffect(() => {
    const id = setInterval(() => setNow(new Date()), 1000);
    return () => clearInterval(id);
  }, []);
  return (
    <div className={styles.clock}>
      <span className={styles.time}>{now.toLocaleTimeString('en-GB')}</span>
      <span className={styles.date}>{now.toLocaleDateString('vi-VN')}</span>
    </div>
  );
}

// === 🧱 Modal chung ===
function Modal({ open, onClose, title, children, type = 'normal' }) {
  if (!open) return null;

  return (
    <div className={clsx(styles.modalOverlay, styles[`modalOverlay${type}`])} onClick={onClose}>
      <div className={clsx(styles.modal, styles[`modal${type}`])} onClick={(e) => e.stopPropagation()}>
        <h3 className={styles.modalTitle}>
          {type === 'virus' && '⚠️'} 
          {type === 'ip' && '📡'} 
          {type === 'auth' && '🔐'} 
          {title}
        </h3>
        {children}
        <button
          className={styles.closeBtn}
          onClick={() => {
            if (type === 'virus') playError();
            onClose();
          }}
        >
          {type === 'virus' ? 'KHÔNG, THOÁT NGAY!' : 'Đóng'}
        </button>
      </div>
    </div>
  );
}

// === 🌐 Lấy thông tin người dùng ===
function IPLocationModal({ open, onClose }) {
  const [info, setInfo] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!open) return;
    playScan(); // ✅ Dùng playScan()

    const fetchIPInfo = async () => {
      let data;
      try {
        const res = await fetch('https://ipapi.co/json/');
        data = await res.json();
        if (!data.ip) throw new Error('No IP');
      } catch (err) {
        try {
          const res2 = await fetch('https://api.ipify.org?format=json');
          const { ip } = await res2.json();
          data = {
            ip,
            org: 'Không xác định (VPN)',
            city: 'Ẩn danh',
            region: 'Ẩn danh',
            country_name: 'Ẩn danh',
            timezone: 'Ẩn danh',
          };
        } catch (e) {
          data = {
            ip: 'Không thể xác định',
            org: 'Không xác định',
            city: 'Không xác định',
            country_name: 'Không xác định',
          };
        }
      }

      const fullInfo = {
        ip: data.ip || 'Không xác định',
        isp: data.org || 'Không xác định',
        city: data.city || 'Không xác định',
        region: data.region || 'Không xác định',
        country: data.country_name || 'Không xác định',
        timezone: data.timezone || 'Không xác định',
        browser: getBrowser(),
        os: getOS(),
        device: getDeviceType(),
        resolution: `${window.screen.width}x${window.screen.height}`,
        language: navigator.language,
        cookies: navigator.cookieEnabled ? '✅ Có' : '❌ Không',
        localStorage: typeof localStorage !== 'undefined' ? '✅ Có' : '❌ Không',
        gpu: getGPU(),
        battery: 'Đang lấy...',
      };

      if ('getBattery' in navigator) {
        (navigator as any).getBattery().then((bat: any) => {
          setInfo(prev => ({
            ...prev,
            battery: `${Math.floor(bat.level * 100)}%${bat.charging ? ' (sạc)' : ''}`
          }));
        }).catch(() => {});
      }

      setInfo(fullInfo);
      setLoading(false);
    };

    fetchIPInfo();
  }, [open]);

  // Các hàm hỗ trợ
  const getOS = () => (/Android/i.test(navigator.userAgent) ? 'Android' : /iPhone|iPad/i.test(navigator.userAgent) ? 'iOS' : /Win/i.test(navigator.userAgent) ? 'Windows' : /Mac/i.test(navigator.userAgent) ? 'macOS' : 'Không xác định');
  const getBrowser = () => navigator.userAgent.includes('Chrome') && !navigator.userAgent.includes('Edg') ? 'Google Chrome' : navigator.userAgent.includes('Firefox') ? 'Firefox' : 'Khác';
  const getDeviceType = () => /Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ? 'Di động' : 'Máy tính';
  const getGPU = () => {
    const canvas = document.createElement('canvas');
    const gl = canvas.getContext?.('webgl') as WebGLRenderingContext | null;
    if (!gl) return 'Không hỗ trợ WebGL';
    const debugInfo = gl.getExtension ? gl.getExtension('WEBGL_debug_renderer_info') : null;
    if (debugInfo && gl.getParameter) {
      return gl.getParameter(debugInfo.UNMASKED_RENDERER_WEBGL) || 'Không xác định';
    }
    return 'Không xác định';
  };

  if (!open) return null;

  return (
    <Modal open={open} onClose={onClose} title="XÁC ĐỊNH DANH TÍNH NGƯỜI DÙNG" type="ip">
      {loading ? (
        <p>🔍 Đang quét thông tin...</p>
      ) : (
        <>
          <p><strong>🌐 IP:</strong> <span style={{ color: '#00ff88' }}>{info.ip}</span></p>
          <p><strong>🏢 ISP:</strong> {info.isp}</p>
          <p><strong>📍 Vị trí:</strong> {info.city}, {info.country}</p>
          <p><strong>🖥️ Thiết bị:</strong> {info.device}</p>
          <p><strong>⚙️ Hệ điều hành:</strong> {info.os}</p>
          <p><strong>🔍 Trình duyệt:</strong> {info.browser}</p>
          <p><strong>📏 Độ phân giải:</strong> {info.resolution}</p>
          <p><strong>🔋 Pin:</strong> {info.battery}</p>
          <p style={{ color: '#ff0066', fontWeight: 'bold', marginTop: '1rem' }}>
            🔴 HỆ THỐNG ĐÃ GHI NHẬN DANH TÍNH BẠN.
          </p>
        </>
      )}
      <button className={styles.closeBtn} onClick={onClose} style={{ marginTop: '1rem' }}>
        ❌ THOÁT
      </button>
    </Modal>
  );
}

// === 💀 Virus Modal ===
function VirusModal({ open, onClose }) {
  const [cameraActive, setCameraActive] = useState(false);
  const [micActive, setMicActive] = useState(false);

  useEffect(() => {
    if (open) {
      playStartup();
      setTimeout(() => playAlert(), 800);
      setTimeout(() => setCameraActive(true), 2000);
      setTimeout(() => setMicActive(true), 2500);
    } else {
      setCameraActive(false);
      setMicActive(false);
    }
  }, [open]);

  return (
    <Modal open={open} onClose={onClose} title="PHÁT HIỆN MÃ ĐỘC" type="virus">
      <p style={{ color: '#ff0066', fontWeight: 'bold' }}>⚠️ Cảnh báo bảo mật!</p>
      <p>Truy cập camera: {cameraActive ? '✅ Đang ghi hình' : '🔄 Đang kết nối...'}</p>
      <p>Ghi âm microphone: {micActive ? '✅ Đang ghi âm' : '🔄 Đang kết nối...'}</p>
    </Modal>
  );
}

// === 🔐 Auth Modal ===
function AuthModal({ open, onClose }) {
  return (
    <Modal open={open} onClose={onClose} title="XÁC THỰC BẢO MẬT" type="auth">
      <p>Hệ thống yêu cầu xác thực:</p>
      <input
        type="password"
        placeholder="Mã 6 số"
        className={styles.authInput}
        maxLength={6}
        onChange={() => playError()}
      />
      <p style={{ color: '#ff0066', fontSize: '0.8rem', marginTop: '1rem' }}>
        ❌ Sai mã. Tài khoản sẽ bị khóa.
      </p>
    </Modal>
  );
}

// === 🚨 Popup cảnh báo tự động (spam) ===
function UnauthorizedAlertPopup({ id, onClose }) {
  useEffect(() => {
    const interval = setInterval(() => playAlert(), 1500);
    return () => clearInterval(interval);
  }, []);

  return (
    <div
      key={id}
      style={{
        position: 'fixed',
        top: `${Math.random() * 70 + 10}vh`,
        left: `${Math.random() * 70 + 10}vw`,
        width: '360px',
        background: '#000',
        border: '2px solid #ff0066',
        borderRadius: 0,
        color: '#00ff88',
        fontFamily: 'Orbitron, monospace',
        fontSize: '13px',
        zIndex: 99999,
        boxShadow: '0 0 20px rgba(255, 0, 102, 0.6)',
        padding: '12px',
        transform: 'translate(-50%, -50%)',
      }}
    >
      <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '8px' }}>
        <strong style={{ color: '#ff0066' }}>⚠️ AN NINH MẠNG</strong>
        <button
          onClick={onClose}
          style={{
            background: '#333',
            color: '#fff',
            border: 'none',
            padding: '1px 5px',
            cursor: 'pointer',
            fontSize: '12px'
          }}
        >
          ✕
        </button>
      </div>
      <p style={{ margin: '4px 0', lineHeight: 1.4 }}>
        <strong>🔴 PHÁT HIỆN XÂM NHẬP</strong><br />
        Thiết bị của bạn đã bị đánh dấu.<br />
        ID: SEC-{Date.now().toString(36).toUpperCase().slice(0, 8)}
      </p>
    </div>
  );
}

// === 🏠 Header chính ===
function HomepageHeader() {
  const { siteConfig } = useDocusaurusContext();
  const [modalType, setModalType] = useState(null);
  const [interacted, setInteracted] = useState(false);
  const [alerts, setAlerts] = useState([]);

  // 🔊 KÍCH HOẠT ÂM THANH SAU CLICK
  useEffect(() => {
    const handleInteraction = () => {
      if (!interacted) {
        loadSounds(); // 🔥 Kích hoạt hệ thống âm thanh
        playBeep(); // ✅ Phát beep đầu tiên
        setInteracted(true);
        // Dọn dẹp
        document.removeEventListener('click', handleInteraction);
        document.removeEventListener('keydown', handleInteraction);
      }
    };
    document.addEventListener('click', handleInteraction);
    document.addEventListener('keydown', handleInteraction);
    return () => {
      document.removeEventListener('click', handleInteraction);
      document.removeEventListener('keydown', handleInteraction);
    };
  }, [interacted]);

  // Auto-spawn popup
  useEffect(() => {
    if (interacted) {
      const timer = setTimeout(() => {
        spawnAlert();
      }, 1000);
      return () => clearTimeout(timer);
    }
  }, [interacted]);

  const spawnAlert = () => {
    const id = Date.now() + Math.random();
    setAlerts(prev => [...prev, id]);
    const nextDelay = Math.max(800, 3000 - alerts.length * 200);
    setTimeout(spawnAlert, nextDelay);
  };

  const closeAlert = (id) => {
    setAlerts(prev => prev.filter(a => a !== id));
    setTimeout(() => {
      const newId = Date.now() + Math.random();
      setAlerts(prev => [...prev, newId]);
    }, 300);
  };

  const openModal = (type) => {
    if (interacted) playBeep();
    setModalType(type);
    setTimeout(() => {
      if (Math.random() > 0.5) setModalType('virus');
    }, 1000);
  };

  const closeModal = () => setModalType(null);

  return (
    <header className={clsx(styles.header)}>
      <div className={styles.bg}></div>
      <div className={styles.scanline}></div>
      <div className={styles.noise}></div>
      <div className={styles.light}></div>

      <div className={styles.center}>
        <Heading as="h1" className={styles.title}>
          {siteConfig.title}
        </Heading>
        <p className={styles.subtitle}>{siteConfig.tagline}</p>
        <DigitalClock />

        <div className={styles.buttonRow}>
          <button className={styles.btn} onClick={() => openModal('ip')}>🔐 Truy cập hệ thống</button>
          <button className={clsx(styles.btn, styles.btnPrimary)} onClick={() => openModal('virus')}>▶️ Khởi động</button>
          <button className={clsx(styles.btn, styles.btnOutline)} onClick={() => openModal('auth')}>🛰️ Mạng lưới</button>
          <button
            className={clsx(styles.btn, styles.btnOutline)}
            onClick={() => {
              openModal('ip');
              setTimeout(() => setModalType('virus'), 1200);
              setTimeout(() => setModalType('auth'), 2400);
            }}
          >
            🤖 AI Core
          </button>
        </div>
      </div>

      {/* Modals */}
      <IPLocationModal open={modalType === 'ip'} onClose={closeModal} />
      <VirusModal open={modalType === 'virus'} onClose={closeModal} />
      <AuthModal open={modalType === 'auth'} onClose={closeModal} />

      {/* Spam popups */}
      {alerts.map(id => (
        <UnauthorizedAlertPopup key={id} id={id} onClose={() => closeAlert(id)} />
      ))}
    </header>
  );
}

export default function Home() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <Layout
      title={`Welcome to ${siteConfig.title}`}
      description="Hacker Terminal - Fake Attack Simulation with Auto-Spam & Sound">
      <HomepageHeader />
      <main className={styles.mainContent}></main>
    </Layout>
  );
}