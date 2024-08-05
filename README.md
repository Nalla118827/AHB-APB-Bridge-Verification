# AHB-APB-Bridge-Verification 🌉

AHB2APB-Bridge The AHB to APB bridge is an AHB slave and the only APB master that provides an interface between the highspeed AHB and the low-power APB. Read and write transfers on the AHB are converted into equivalent transfers on the APB.

# About the AMBA Buses 🚌
The Advanced Microcontroller Bus Architecture (AMBA) specification defines an on-chip communications standard for designing high-performance embedded microcontrollers. Three distinct buses are defined within the AMBA specification:

👉 Advanced High-performance Bus (AHB) </br>
👉 Advanced System Bus (ASB) </br>
👉 Advanced Peripheral Bus (APB).</br>

# Advanced High-performance Bus (AHB)
The AMBA AHB is for high-performance, high clock frequency system modules. The AHB acts as the high-performance system backbone bus. AHB supports the efficient connection of processors, on-chip memories and off-chip external memory interfaces with low-power peripheral macrocell functions. AHB is also specified to ensure ease of use in an efficient design flow using synthesis and automated test techniques.

# Advanced System Bus (ASB)
The AMBA ASB is for high-performance system modules. AMBA ASB is an alternative system bus suitable for use where the high-performance features of AHB are not required. ASB also supports the efficient connection of processors, on-chip memories and off-chip external memory interfaces with low-power peripheral macrocell functions.

# Advanced Peripheral Bus (APB)
The AMBA APB is for low-power peripherals. AMBA APB is optimized for minimal power consumption and reduced interface complexity to support peripheral functions. APB can be used in conjunction with either version of the system bus.

The overall architecture looks like the following:
![Screenshot 2024-08-04 224346](https://github.com/user-attachments/assets/1cf0b5de-aaca-4811-bc6f-860dc7e74140)

![Screenshot 2024-08-05 155910](https://github.com/user-attachments/assets/cae6f3bd-4c8e-497c-8f92-4a8a197a00f5)


# INTRODUCTION TO AHB PROTOCOL 
AHB is a new generation of AMBA bus which is intended to address the requirements of high-performance synthesizable designs. It is a high-performance system bus that supports multiple bus masters and provides high-bandwidth operation.

AMBA AHB implements the features required for high-performance, high clock frequency systems including:

• burst transfers </br>
• split transactions </br>
• single-cycle bus master handover </br>
• single-clock edge operation </br>
• non-tristate implementation </br>
• wider data bus configurations (64/128 bits).</br>

<img src="https://github.com/user-attachments/assets/d972e386-bb02-435d-bb13-9b5450d8a8d9" alt="Your Image" width="500" align="right" style="margin-right: 200px;">

Bridging between this higher level of bus and the current ASB/APB can be done efficiently to ensure that any existing designs can be easily integrated.

An AMBA AHB design may contain one or more bus masters, typically a system would contain at least the processor and test interface. However, it would also be common for a Direct Memory Access (DMA) or Digital Signal Processor (DSP) to be included as bus masters.

The external memory interface, APB bridge and any internal memory are the most common AHB slaves. Any other peripheral in the system could also be included as an AHB slave. However, low-bandwidth peripherals typically reside on the APB.

# AHB SIGNALS DESCRIPTION 📶

![Screenshot 2024-08-04 230730](https://github.com/user-attachments/assets/edb2ad2d-7ac8-4372-930f-76e9ff57c6a2)

Every transfer consists of: </br> 
➡️ An address and control cycle </br>
➡️ One or more cycles for the data. </br>
The address cannot be extended and therefore all slaves must sample the address during this 
time. The data, however, can be extended using the HREADY signal. When LOW this signal 
causes wait states to be inserted into the transfer and allows extra time for the slave to provide or sample data.

<img src="https://github.com/user-attachments/assets/1d6a5f7e-0ec6-4eef-a188-e8360b9deedc" alt="Your Image" width="800"  style="margin-right: 50px;">
<img src="https://github.com/user-attachments/assets/fd10b337-e1a8-4ed6-b776-5e8846eb3a8e" alt="Your Image" width="800"  style="margin-right: 50px;">

# INTRODUCTION TO APB PROTOCOL
The APB protocol is a low-cost interface, optimized for minimal power consumption and reduced interface 
complexity. The APB interface is not pipelined and is a simple, synchronous protocol. Every transfer takes at least two cycles to complete.
The APB interface is designed for accessing the programmable control registers of peripheral devices. APB 
peripherals are typically connected to the main memory system using an APB bridge. For example, a bridge from 
AXI to APB could be used to connect a number of APB peripherals to an AXI memory system.
APB transfers are initiated by an APB bridge. APB bridges can also be referred to as a Requester. A peripheral 
interface responds to requests. APB peripherals can also be referred to as a Completer. This specification will use 
Requester and Completer

# FSM OF APB(OPERATING STATES)
<img src="https://github.com/user-attachments/assets/2a0b6d50-1941-44dc-ab39-5f1c00fd9c69" alt="Your Image" width="300" align="right" style="margin-right: 20px;">

The state machine operates through the following states:</br>
**IDLE** </br> This is the default state of the APB interface.</br>
**SETUP**</br> When a transfer is required, the interface moves into the SETUP state, where the appropriate select 
signal, PSELx, is asserted. The interface only remains in the SETUP state for one clock cycle and 
always moves to the ACCESS state on the next rising edge of the clock.</br>
**ACCESS**</br> The enable signal, PENABLE, is asserted in the ACCESS state. The following signals must not 
change in the transition between SETUP and ACCESS and between cycles in the ACCESS state:

• PADDR </br>
• PPROT </br>
• PWRITE </br>
• PWDATA, only for write transactions </br>
• PSTRB </br>
• PAUSER </br>
• PWUSER </br>

Exit from the ACCESS state is controlled by the PREADY signal from the Completer: </br>
• If PREADY is held LOW by the Completer, then the interface remains in the ACCESS state.
• If PREADY is driven HIGH by the Completer, then the ACCESS state is exited and the bus 
returns to the IDLE state if no more transfers are required. Alternatively, the bus moves 
directly to the SETUP state if another transfer follows

# APB SIGNAL DESCRIPTION 📶

<img src="https://github.com/user-attachments/assets/75206614-dbb8-4d9e-ab37-74485eed4009" alt="Your Image" width="500"  style="margin-right: 20px;">

<img src="https://github.com/user-attachments/assets/d9a567fd-988e-410c-80a0-638addb9ca83" alt="Your Image" width="500"  style="margin-right: 50px;">

# AHB TO APB BRIDGE🌉
The AHBtoAPB Bridge is an AHB slave, providing an interface between the high-speed AHB 
and the low-power APB. Read and write transfers on the AHB are converted into equivalent 
transfers on the APB. As the APB is not pipelined, then wait states are added during transfers 
to and from the APB when the AHB is required to wait for the APB.

<img src="https://github.com/user-attachments/assets/1e3fe21f-d9d8-4632-876f-45f484c59d6e" alt="Your Image" width="500" align="right" style="margin-right: 20px;">

The bridge unit converts system bus transfers into APB transfers and performs the following 
functions:</br>

👉 Latches the address and holds it valid throughout the transfer.</br>
👉 Decodes the address and generates a peripheral select, PSELx. Only one select signal can be active during a transfer.</br>
👉 Drives the data onto the APB for a write transfer.</br>
👉 Drives the APB data onto the system bus for a read transfer.</br>
👉 Generates a timing strobe, PENABLE, for the transfer.</br>


