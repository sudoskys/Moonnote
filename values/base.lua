

import "java.io.File"
import "android.os.Environment"
--创目录
function Openroad()
  root_path=Environment.getExternalStorageDirectory().toString().."/monote/"
  note=root_path.."note/"
  change=root_path.."change/"
  pics=root_path.."picture/"
  File(root_path).mkdirs()
  File(note).mkdirs()
  File(pics).mkdirs()
  File(change).mkdirs()
  noteDirFile=File(note)
  notePath=root_path
end
Openroad()
function ifex(file)
  return File(file).exists()
end
if ifex(root_path.."fuhao.dat") then
 else
  io.open(root_path.."fuhao.dat", 'w')

  io.open(root_path.."fuhao.dat","w+"):write([[
### 
## 
# 
``
>
`
- 
*
**
]]):close()
end


maincolor="#ff51A8DD"

subcolor="#FF74AAFF"

txtcolor="#efffffff"

backcolor="#efffffff"

sancolor="#efffffff"

imagecolor="#efffffff"