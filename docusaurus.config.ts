import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';
import remarkMath from 'remark-math';
import rehypeKatex from 'rehype-katex';


const math = require('remark-math');
const katex = require('rehype-katex');

const config: Config = {
  title: 'DOCS',
  tagline: 'Next-Gen Development Framework',
  favicon: 'img/favicon.ico',

  future: {
    v4: true,
  },

  url: 'https://tienthien196.github.io',
  baseUrl: '/ecosys.documents/',

  organizationName: 'tienthien196',
  projectName: 'ecosys.documents',

  onBrokenLinks: 'warn',
  onBrokenMarkdownLinks: 'warn',

  
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          remarkPlugins: [math],
          rehypePlugins: [katex],
        },
        blog: {
          remarkPlugins: [math],
          rehypePlugins: [katex],
        },
        theme: {
          customCss: './src/css/custom.css',
        },  
      } satisfies Preset.Options,
      
    ],
  ],
  stylesheets: [
    {
      href: 'https://cdn.jsdelivr.net/npm/katex@0.16.9/dist/katex.min.css',
      type: 'text/css',
      integrity:
        'sha384-wvUvB2KN7pQCO+U/wS9GehG+jw/adJzi10BGSAdoo6gWQBaIj++ImQxGcH2CqkGp',
      crossorigin: 'anonymous',
    },
  ],


  themeConfig: {
    image: 'img/docusaurus-social-card.jpg',

    // === NAVBAR: Thay chữ bằng logo, các item thành button ===
    navbar: {
      title: '', // ❌ Không dùng chữ
      logo: {
        alt: 'TNT Engine Logo',
        src: 'img/344451.jpg', // ✅ Dùng logo nghệ thuật
        width: 50,
        height: 50,
      },
      style: 'dark',
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'tutorialSidebar',
          position: 'left',
          label: 'DOCS',
          className: 'nav-button',
        },
        {to: '/blog', label: 'BLOG', position: 'left', className: 'nav-button'},
        {type: 'search', position: 'right', className: 'nav-button search-btn'},
        {
          href: 'https://github.com/tienthien196',
          label: 'GITHUB',
          position: 'right',
          className: 'nav-button github-btn',
        },
      ],
    },

    // === FOOTER: Giữ nguyên hoặc nâng cấp sau ===
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            { label: 'Tutorial', to: '/docs/intro' },
          ],
        },
        {
          title: 'Community',
          items: [
            { label: 'Discord', href: 'https://discordapp.com/invite/docusaurus' },
            { label: 'X', href: 'https://x.com/docusaurus' },
          ],
        },
        {
          title: 'More',
          items: [
            { label: 'Blog', to: '/blog' },
            { label: 'GitHub', href: 'https://github.com/tienthien196' },
          ],
        },
      ],
      copyright: `© ${new Date().getFullYear()} Docs support GM Finn. Built with Docusaurus.`,
    },

    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies Preset.ThemeConfig,
};

export default config;