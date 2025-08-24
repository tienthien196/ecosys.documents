import useSound from 'use-sound';

// Danh sách URL âm thanh từ CDN (free & public)
const SOUNDS = {
  BEEP: 'https://assets.mixkit.co/sfx/preview/mixkit-software-interface-start-2574.mp3',
  ALERT: 'https://assets.mixkit.co/sfx/preview/mixkit-alarm-digital-clock-beep-989.mp3',
  ERROR: 'https://assets.mixkit.co/sfx/preview/mixkit-wrong-bleep-2044.mp3',
  SCAN: 'https://assets.mixkit.co/sfx/preview/mixkit-keyboard-click-1350.mp3',
  STARTUP: 'https://assets.mixkit.co/sfx/preview/mixkit-unlock-game-notification-253.mp3',
};

// Hook âm thanh hệ thống
const useSystemSound = () => {
  const [playBeep] = useSound(SOUNDS.BEEP, { volume: 0.3 });
  const [playAlert] = useSound(SOUNDS.ALERT, { volume: 0.5 });
  const [playError] = useSound(SOUNDS.ERROR, { volume: 0.4 });
  const [playScan] = useSound(SOUNDS.SCAN, { volume: 0.2 });
  const [playStartup] = useSound(SOUNDS.STARTUP, { volume: 0.4 });

  return {
    beep: playBeep,
    alert: playAlert,
    error: playError,
    scan: playScan,
    startup: playStartup,
  };
};

export default useSystemSound;