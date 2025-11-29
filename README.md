# GPA Calculator – Assembly (8086)

- A simple GPA / Average Grade Calculator written in 8086 Assembly language using MS-DOS interrupts (INT 21h).
- The program reads the number of subjects, takes each grade with validation, calculates the final average, counts the number of failed subjects, and determines the academic status (Excellent, Pass, Carry, Fail… etc).

---

## ⭐ Features

- Input validation for:
  - Number of subjects (1–9)
  - Grade input (0–100)
- Converts multi-digit ASCII input to decimal
- Calculates final average automatically
- Displays grade category:
  - Excellent
  - Very Good
  - Good
  - Clean Pass (No Fails)
  - Pass with Carry (Takhalluf)
  - Fail (Average < 50 or ≥ 3 fails)
- Custom routine for printing decimal numbers (0–100)

---

## 📌 How the Program Works

1. Prompts the user to enter the number of subjects
2. Reads each grade individually
3. Validates the input (rejects invalid numbers)
4. Detects if any subject is failed (< 50).
5. Sums all grades .
6. Computes the average using integer division.
7. Displays:

- Final Average Grade
- Academic Status
- Carry subjects (if any)

---

## 🛠 Technologies Used

- Assembly 8086
- MS-DOS Interrupts (INT 21h)
- GUI Turbo Assembler (TASM)

---

## 📂 Project Files

- `gpa.asm` → Main Assembly source code

---

## ▶️ How to Run

- Using GUI Turbo Assembler (TASM):

  1. Open `gpa.asm` in TASM.
  2. Assemble the program → Click Run.

- Using DOSBox:
  1. Mount the folder containing `gpa.asm`.
  2. Assemble with TASM: `tasm gpa.asm`
  3. Link with TLINK: `tlink gpa.obj`
  4. Run the executable: `gpa.exe`

---

## 👩‍💻 Author

- Menna Rashad
- Menna Maged
- Menna Sherif
