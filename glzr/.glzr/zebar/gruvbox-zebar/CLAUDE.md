# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Zebar widget configuration using React + TypeScript + Vite for creating a system taskbar/status bar. The widget is designed for GlazeWM (a tiling window manager) and displays various system information segments like workspaces, system stats, time zones, and media information.

## Common Commands

### Development
```bash
# Start development server with hot reload
npm run dev

# Build for production
npm run build

# Lint code
npm run lint

# Preview production build
npm run preview
```

### Widget Management
The widget is packaged as a Zebar package defined in `zpack.json`. After building:
- The built files are in `dist/` directory
- Widget loads from `dist/index.html`
- Widget dimensions: 100% width × 40px height, docked to top edge

## Architecture

### Component Structure
The app follows a three-section layout pattern:
- **Left**: Workspaces and tiling direction controls
- **Center**: Multi-timezone clock and date display  
- **Right**: System monitoring segments (CPU, memory, network, battery, weather, media)

### Key Components
- **App.tsx**: Root component orchestrating Left/Center/Right layout
- **Segment.tsx**: Reusable UI component for all status bar elements with icon, pill, and click handling
- **Provider Pattern**: Uses Zebar's `createProvider()` for system data (battery, CPU, GlazeWM, etc.)

### Segment Architecture  
Each segment follows the same pattern:
1. Create provider using `createProvider()` with specific type
2. Use `useState` and `useEffect` to manage provider output
3. Render using shared `Segment` component with consistent styling
4. Support optional click handlers for interactive elements

### Data Providers
Segments connect to system data via Zebar providers:
- `glazewm`: Window manager state (workspaces, binding modes)
- `battery`: Power status and charge level
- `cpu`: Processor usage statistics  
- `memory`: RAM usage information
- `network`: Network connection status
- `date`: Time/date formatting with timezone support
- `weather`: Weather information
- `media`: Currently playing media

### Styling System
- CSS Modules for component-specific styles (`*.module.css`)
- Global styles in `index.css` and `normalize.css`
- Nerd Font icons (`nf` classes) for consistent iconography
- Gruvbox color scheme with pill-shaped segments

### TypeScript Configuration
- Split TypeScript configs: `tsconfig.app.json` for app code, `tsconfig.node.json` for build tools
- React 19 with strict TypeScript checking
- Vite build system with React plugin

### GlazeWM Integration
- Interactive workspace switching via `glazewm.runCommand()`
- Displays binding modes and workspace focus states
- Supports tiling direction controls

The codebase prioritizes modularity through the segment pattern, making it easy to add/remove/modify individual status bar elements while maintaining consistent UI and data patterns.