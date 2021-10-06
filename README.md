# Gaussian LPF
Slightly modified Low-Pass Filter, introducing upsampling & downsampling for better compression

*[intially written in MATLAB R2017b]*

*Use MATLAB R2020+, or use the subroutine **myfun** as a separate script.*

- Simply run the **LPF.m** file. **"myfun"** is a subroutine of **LPF.m** file.
- To change the Image you want to filter, simply edit the "Line #1" in **LPF.m** file.
- The new input Image  must be in the same directory as of **LPF.m** file.
- By default, the code takes "bsec.jpg" as example, processes it, then saves it as "comp.jpg" file.
- Without any filtering, MATLAB uses its own compression. So, don't be overwhelmed here. Further filtering makes the input Image more compressed.
