require "import"
import "android.widget.*"
import "android.view.*"
import "values.base"
import "mods.runbase"
root_path=Environment.getExternalStorageDirectory().toString().."/monote/"
--github@sudoskys
function saveouts()
  activity.newTask(function(noteDirFile,notePath,root_path)
    require "import"
    import "java.io.*"
    fl=luajava.astable(noteDirFile.listFiles())
    table.sort(fl,function(a,b)
      return string.upper(a.Name)<string.upper(b.Name)
    end)
    datas={}
    function getDirNumber(file,dirname)
      import "java.io.*"
      --      if File(tostring(file).."/"..dirname).isDirectory() then
      local file=File(tostring(file).."/"..dirname)
      local list=file.listFiles()
      local tableList=luajava.astable(list)
      local number=table.size(tableList)
      luajava.clear(file)
      luajava.clear(list)
      local tableList=nil
      return number
      --     else
      --       File(tostring(file).."/"..dirname).mkdirs()
      -- print("不存在")
      --   end
    end
    function Filesuffix(name)
      return name:match(".+%.(%w+)$")
    end

    function StrToTable(str)
      if str == nil or type(str) ~= "string" then
        return
      end
      return loadstring("return " .. str)()
    end

    function getActuallyTitle(ori)
      if #ori<1 then
        return "无标题"
       else
        return ori
      end
      print (ori)
    end
    function wrpath(paths,contents)
      import"java.io.File"
      f=File(tostring(File(tostring(paths)).getParentFile())).mkdirs()
      io.open(tostring(paths),"w"):write(tostring(contents)):close()
    end

    function getActuallyContent(ori)
      if #ori<1 then
        return "无内容"
       else
        return ori
      end
      print (ori)
    end

    for index,content in ipairs(fl) do
      if pcall(function()------------------------

          if content.isDirectory() then
           else
            date=getActuallyTitle(StrToTable(io.open(tostring(content)):read("*a"))["content"]["title"])
            textto=getActuallyContent(string.gsub(string.gsub(StrToTable(io.open(tostring(content)):read("*a"))["content"]["messages"],":xjszkh:","["),":xjsykh:","]"))
            likes=(Filesuffix(tostring(content)))
            roads=tostring(content)
            --构建目标路径
            saveout=root_path.."saveout/"
            File(saveout).mkdirs()
            --构建文件路径
            outname=saveout..date.."_"..index.."."..likes
            --写出文件
            wrpath(outname,textto)
            print("OK:"..outname)
          end
        end) then
       else
        print("打包失败，无法读取:"..tostring(content))
      end------------------------
    end
    ------------------------
    return datas
  end
  ,function(datas)
    --打包分享目标路径
    saveout=root_path.."saveout/"
    zipshare(saveout,root_path)
  end).execute({noteDirFile,notePath,root_path})

end


function zipshare(zippath,root_path)
  activity.newTask(function(zippath,root_path)
    require "import"
    this.update("正在打包中...")
    shareout=root_path.."/shared"
    return ZipUtil.zip(zippath,shareout)
  end
  ,function(info)
    showLoadingDia(info)
  end
  ,function(succeed,exit,num)
    os.execute("rm -r "..zippath)

    --分享并删除文件夹
    shared(root_path.."/shared".."/saveout.zip")
    closeLoadingDia()
    executeState2Toast(succeed,exit,num,"压缩")
    print("打包完毕:"..root_path.."/shared".."".."，删除请手动删除")
    --  分享文件(backupPath.."/zip/"..date..".zip")
  end).execute({zippath,root_path})
end



function shared(path)
  if pcall(function()
      import "android.webkit.MimeTypeMap"
      import "android.content.Intent"
      import "android.net.Uri"
      import "java.io.File"
      FileName=tostring(File(path).Name)
      ExtensionName="zip"
      --FileName:match(".+%.(%w+)$")
      Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
      intent=Intent()
      intent.setAction(Intent.ACTION_SEND)
      intent.setType(Mime)
      file=File(path)
      uri=Uri.fromFile(file)
      intent.putExtra(Intent.EXTRA_STREAM,uri)
      intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      activity.startActivity(Intent.createChooser(intent,"分享笔记"))
    end) then
   else
    print("分享出现错误....")
  end
end
