This project implements a **Morse Code Transmitter** in **Verilog** for the DE10-Nano FPGA.  
It transmits the letters **A–H** in Morse code by blinking LEDs using a finite state machine, shift register, and a half-second counter.

---

## Features
- Supports **letters A–H** in Morse code:
  - A → • —  
  - B → — • • •  
  - C → — • — •  
  - D → — • •  
  - E → •  
  - F → • • — •  
  - G → — — •  
  - H → • • • •  
- **KEY[0]** → Start transmission  
- **KEY[1]** → Reset (active low)  
- **SW[2:0]** → Select letter  
- **LED[0]** → LED output for Morse code blink  
- **LED[7:5]** → Debug (displays selected letter input)


<p align="center">
  <img src="https://github.com/user-attachments/assets/c98beab8-c079-49ec-bcdd-6185d5f29f72" alt="Letter E Morse Code Demo" width="400"/>
  <br>
  <em>Demo-ing the Letter E Morse code transmission!</em>
</p>




<p align="center">
  <img width="788" height="376" alt="Screenshot 2025-09-17 010550" src="https://github.com/user-attachments/assets/01c0dc85-9224-4e0a-920d-d4e292d40350" />
  <br>
  <em>High-level design flow</em>
</p>
