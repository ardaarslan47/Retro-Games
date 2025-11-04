# Retro Games Collection

This project is a collection of classic retro games developed using **LÖVE2D (Love2D)**.  
It includes the following four games:

- **Pong**  
- **Breakout**  
- **Snake**  
- **Tetris**

Each game has two versions: one for **keyboard** and one for **controller (gamepad)**.  
The project is fully open source and aims to recreate the nostalgic feel of retro arcade games.

---

## Installation and Running

1. Install [LÖVE2D](https://love2d.org/).  
2. Clone or download this repository:
   ```bash
   git clone https://github.com/ardaarslan47/retro-games.git
   ```
3. Run the games with:
   ```bash
   love .
   ```
   or open the `.love` files directly:
   - `retro-games.love` → Controller version  
   - `klavye-retro-games.love` → Keyboard version

---

## Controls

### Keyboard
- **Arrow Keys**: Move  
- **Space / Enter**: Select or Start  
- **Esc**: Return to main menu

### Controller
- **D-Pad / Analog Stick**: Move  
- **A / Start**: Select or Start  
- **B / Back**: Go back

---

## Project Structure

```
fonts/      → Game fonts
graphics/   → Sprites and visual assets
sounds/     → Sound effects
src/        → Source code
lib/        → Libraries and dependencies
main.lua    → Main entry point
```

---

## Notes

- Tested with LÖVE2D version 11.x  
- Each game includes its own menu and score system  
- More games may be added in future updates
