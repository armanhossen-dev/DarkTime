# Hyperframes Composition Brief: DarkTime

## Objective
Create a short, cinematic, high-precision launch brag video for DarkTime v5.0.

## Output
- Composition directory: `brag-output/composition/`
- Rendered video: `brag-output/brag.mp4`
- Poster frame: `brag-output/brag.jpg`
- Format: landscape — 1920x1080
- Duration: 20 seconds

## Source Material
- Project root: `/Users/armanhossenripon/Documents/GitHub/DarkTime`
- Primary files read: `index.html`, `style/index.css`, `code/index.js`, `README.md`, `img/v.5.0.png`, `img/v.5.2.png`, `img/clock.png`
- Product name: DarkTime
- Version: v5.0
- Tagline / strongest claim: "A minimalist, industrial-grade digital clock engineered for focus. OLED Optimized (#000000) with JetBrains Mono precision."
- Key UI or visual moment to recreate:
  - Exact DarkTime monospace clock face: tabular digits, colons, `HOURS AM`, `MINUTES`, `SECONDS` sub-labels, and date/day display with surrounding lines.
  - Interactive glassmorphism toast: `<strong>Tip:</strong> Double-click to toggle Fullscreen mode.` with backdrop blur and border.
  - Double-tap simulated cursor interaction expanding into true fullscreen.
  - Multi-scale responsive showcase highlighting Desktop 4K and Mobile portrait with the "Hidden Dot" vertical stack.
- Copy that must appear verbatim:
  - "DarkTime | The High-Contrast Digital Lab"
  - "Tip: Double-click to toggle Fullscreen mode."
  - "HOURS AM", "MINUTES", "SECONDS"
  - "OLED Optimized (#000000)"
  - "JetBrains Mono Typography"
  - "darktime.vercel.app"

## Creative Direction
- Tone preset: `cinematic`
- Creative direction: High-precision industrial product film for technical workstations
- Interpretation: Confident architectural pacing, striking typographic scale in pure white against deep OLED void black, punctuated by tactile interaction and subtle audio-reactive breathing.
- Angle: DarkTime is not a trivial widget; it is an industrial instrument engineered to eliminate workstation distraction.
- Hook: "WORKSTATIONS ARE NOISY. TIME SHOULD BE PURE."
- Outro / punchline: "DarkTime v5.0 | THE HIGH-CONTRAST DIGITAL LAB — darktime.vercel.app"
- Avoid:
  - Generic SaaS language or cartoonish animations
  - Abstract filler shapes or colorful gradients (must stay true to DarkTime's OLED deep black & crisp white identity)
  - Blurry or illegible typography

## Visual Identity
- Background: `#000000` (OLED Pure Black)
- Text: `#ffffff` (High-contrast pure white)
- Sub-text: `rgba(255, 255, 255, 0.45)` (Sub-labels and metadata)
- Glass Toast: `background: rgba(255, 255, 255, 0.08); backdrop-filter: blur(15px); border: 1px solid rgba(255, 255, 255, 0.15);`
- Display font: `'JetBrains Mono', monospace`
- Body font: `'JetBrains Mono', monospace`
- Visual references from the project: Monospace digit layout from `style/index.css`, glassmorphism toast from `code/index.js`, project icon `img/clock.png`, and screenshot assets.

## Storyboard
Total Duration: 20.0s (5 scenes)
1. **Scene 1: The Problem (0.0s – 3.5s)**: Deep void. "WORKSTATIONS ARE NOISY." followed by "TIME SHOULD BE PURE." Monolithic monospace colon `:` pulses.
2. **Scene 2: The Core Instrument (3.5s – 8.75s)**: Reveal of the iconic DarkTime face `10 : 42 : 58` with `HOURS AM`, `MINUTES`, `SECONDS` sub-labels. Hardware sync ticking live. Beat-locked at 8.74s.
3. **Scene 3: Double-Tap Immersion (8.75s – 13.5s)**: Simulated cursor enters and double-clicks. Glass toast appears (`Tip: Double-click to toggle Fullscreen mode`). Viewport smoothly expands into borderless fullscreen. Beat-locked at 13.11s.
4. **Scene 4: The Industrial Architecture (13.5s – 17.5s)**: Three engineered pillars slam in along beat-grid: OLED Black (#000000), JetBrains Mono, Fluid Adaptive Scaling. Side-by-side desktop and mobile portrait preview. Beat-locked at 17.47s.
5. **Scene 5: Outro / Punchline (17.5s – 20.0s)**: "DarkTime v5.0 | THE HIGH-CONTRAST DIGITAL LAB", live URL `darktime.vercel.app`, bell toll, fade to pure black.

## Audio
- Audio role: Pure tactile interface sound design (no background music).
- Audio arc: Tactile clicks on hook line reveals -> dramatic clock reveal slam -> mechanical second ticks -> double-click interaction -> glass toast popup drop -> fullscreen snap -> spec card popups -> resonant outro bell.
- Music: None (disabled per user instruction: "without music just animation click and popup sounds").
- Music treatment: None.
- Audio-reactive treatment: None.
- Audio-coupled moments:
  - 0.5s & 1.3s: Hook line reveals (`click_001.ogg`)
  - 3.5s: Reveal slam (`impactSoft_medium_001.ogg`)
  - 5.5s & 6.5s: Second rollovers (`select_008.ogg`)
  - 9.2s & 9.4s: Double-click interaction (`mouseclick1.ogg` + `click_003.ogg`)
  - 9.5s: Glass toast popup drop (`drop_001.ogg`)
  - 10.3s: Fullscreen expansion switch (`switch_001.ogg`)
  - 13.64s, 14.73s, 15.84s: Architecture spec card popups (`drop_002.ogg`)
  - 17.5s: Final brand mark and outro bell (`impactBell_heavy_000.ogg`)
  - 18.0s: CTA URL badge popup (`click1.ogg`)
- Audio files:
  - `assets/sfx/interface/click_001.ogg`
  - `assets/sfx/impact/impactSoft_medium_001.ogg`
  - `assets/sfx/interface/select_008.ogg`
  - `assets/sfx/ui/mouseclick1.ogg`
  - `assets/sfx/interface/click_003.ogg`
  - `assets/sfx/interface/drop_001.ogg`
  - `assets/sfx/interface/switch_001.ogg`
  - `assets/sfx/interface/drop_002.ogg`
  - `assets/sfx/impact/impactBell_heavy_000.ogg`
  - `assets/sfx/ui/click1.ogg`

## Hyperframes Instructions
- Implement standalone composition in `brag-output/composition/` with `index.html`.
- Canvas dimensions: 1920x1080, duration 20s.
- Load GSAP from CDN or local bundle.
- Ensure all text has sufficient settled read time.
- Verify `npx hyperframes check` passes cleanly before rendering.
