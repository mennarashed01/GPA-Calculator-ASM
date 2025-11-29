# GPA Calculator – Assembly (8086)

* A simple GPA / Average Grade Calculator written in 8086 Assembly language using MS-DOS interrupts (INT 21h).
* The program allows the user to enter the number of subjects, read each grade with validation, calculate the final average, and display an evaluation based on the result.

---

## ⭐ Features

* Input validation for:
  * Number of subjects (1–9)
  * Grade input (0–100)
* Converts multi-digit ASCII input to decimal
* Calculates final average automatically
* Displays grade category:
  * Excellent
  * Very Good
  * Good
  * Pass
  * Fail
* Custom routine for printing decimal numbers (0–100)

---

## 📌 How the Program Works

1. Prompts the user to enter the number of subjects
2. Reads each grade individually
3. Validates the input (rejects invalid numbers)
4. Sums all grades and computes the average
5. Displays:
  * Final average degree
  * Final average grade
  * Grade category (Excellent / Very Good / Good / Pass / Fail)

---

## 🛠 Technologies Used

* Assembly 8086
* MS-DOS Interrupts (INT 21h)
* GUI Turbo Assembler (TASM)

---

## 📂 Project Files

* `gpa.asm` → Main Assembly source code

---

## ▶️ How to Run

* Using GUI Turbo Assembler (TASM):
  1. Open `gpa.asm` in TASM.
  2. Assemble the program → Click Run.

* Using DOSBox:
  1. Mount the folder containing `gpa.asm`.
  2. Assemble with TASM: `tasm gpa.asm`
  3. Link with TLINK: `tlink gpa.obj`
  4. Run the executable: `gpa.exe`

---

## 👩‍💻 Author

* Menna Rashad
* Menna Maged
* Menna Sherif
