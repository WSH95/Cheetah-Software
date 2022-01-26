## cmake error
**1.** `googletest`
- `/common/CMakeLists.txt`. &ensp;Change `master` to `main`.
- If clone googletest from github failed, add `github.com` and `github.global.ssl.fastly.net` into `/etc/hosts`.
- If googletest still can not be cloned, add `xx.xx.xx.xx github.com git` below the localhost where `xx.xx.xx.xx` is the local IP.

**2.** `/scripts/find_qt_path.sh`. &ensp;Replace `~/QT/` with the correct path.

**3.** `/sim/CMakeLists.txt`. &ensp;Set path of `Qt5Core_DIR` `Qt5Widgets_DIR` `Qt5Gui_DIR` `Qt5Gamepad_DIR`.
- ```
  set(Qt5Core_DIR /your_QT_install_path/Qt5.14.0/5.14.0/gcc_64/lib/cmake/Qt5Core)
  set(Qt5Widgets_DIR /your_QT_install_path/Qt5.14.0/5.14.0/gcc_64/lib/cmake/Qt5Widgets)
  set(Qt5Gui_DIR /your_QT_install_path/Qt5.14.0/5.14.0/gcc_64/lib/cmake/Qt5Gui)
  set(Qt5Gamepad_DIR /your_QT_install_path/Qt5.14.0/5.14.0/gcc_64/lib/cmake/Qt5Gamepad)
  ```

## build error
**1.** `[-Werror=stringop-truncation]`
```
return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
```
**solution:**  
- add '-Wno-stringop-truncation' into compile option of CMakeLists.txt  

**2.** `GL/glut.h`
```
/Cheetah-Software/sim/src/Graphics3D.cpp:12:10: fatal error: GL/glut.h: No such file or directory
   12 | #include <GL/glut.h>
```
**solution:**
- download [freeglut3-dev](https://packages.ubuntu.com/focal/amd64/freeglut3-dev/download).
- ```
  sudo dpkg -i freeglut3-dev_2.8.1-3_amd64.deb
  ```

**3.** `stropts.h`
```
/Cheetah-Software/robot/src/rt/rt_serial.cpp:24:10: fatal error: stropts.h: No such file or directory
   24 | #include <stropts.h>
```
**solution:**
- replace `#include <stropts.h>` with `#include <sys/ioctl.h>`
- replace `#include <asm/termios.h>` with `#include <asm/ioctls.h>` `#include <asm/termbits.h>`  
- explanation:
  - <stropts.h> is odd file. It is no longer needed anymore. So there is no such file in ubuntu system include dictionary. 
  - It seems that asm/termios.h indeed collides with sys/ioctl.h. Now the definition which the latter brings are actually equivalent with the ones provided by asm/termios.h. But asm/termios.h also includes asm/termbits.h and asm/ioctls.h which is what we are actually interested in. So instead of including asm/termios.h, you can include those directly. 