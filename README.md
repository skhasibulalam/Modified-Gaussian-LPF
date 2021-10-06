# Gaussian LPF
Slightly modified Low-Pass Filter, introducing upsampling & downsampling for better compression

*[intially written in MATLAB R2017b]*

*Use MATLAB R2020+, or use the subroutine **myfun** as a separate script.*

- Simply run the **LPF.m** file. **"myfun"** is a subroutine of **LPF.m** file.
- To change the image you want to filter, simply edit the "Line #1" in **LPF.m** file.
- The new input image must be in the same directory as of **LPF.m** file.
- By default, the script takes "actual.jpg" for filtering, then saves it as "compressed.jpg".
- Without any filtering, MATLAB uses its own compression. So, don't be overwhelmed here. Further filtering makes the input image more compressed.

N.B. *Use image having dimension of power of 2*
