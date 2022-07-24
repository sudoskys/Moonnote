require "import"
import "android.widget.*"
import "android.view.*"
--github@sudoskys
require "import"
import "android.widget.ArrayAdapter"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "android.widget.ListView"
import "android.app.AlertDialog"


import "values.base"
import "mods.runbase"
import "android.widget.TextView"
import "android.os.Environment"
import "java.io.File"

function ChoicePath(StartPath,callback)
  --创建ListView作为文件列表
  lv=ListView(activity).setFastScrollEnabled(true)
  --创建路径标签
  cp=TextView(activity)
  lay=LinearLayout(activity).setOrientation(1).addView(cp).addView(lv)
  ChoiceFile_dialog=AlertDialog.Builder(activity)--创建对话框
  .setTitle("选择文件夹路径")
  .setPositiveButton("OK",{
    onClick=function()
      callback(tostring(cp.Text))
  end})
  .setNegativeButton("Canel",nil)
  .setView(lay)
  .show()
  adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
  lv.setAdapter(adp)
  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    cp.Text=tostring(path)--设置当前路径
    if path~="/" then--不是根目录则加上../
      adp.add("../")
    end
    ls=File(path).listFiles()
    if ls~=nil then
      ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
      table.sort(ls,function(a,b)
        return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
      end)
     else
      ls={}
    end
    for index,c in ipairs(ls) do
      if c.isDirectory() then--如果是文件夹则
        adp.add(c.Name.."/")
      end
    end
  end
  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Text)
    if tostring(cp.Text)=="/" then
      路径=ls[p+1]
     else
      路径=ls[p]
    end

    if 项目=="../" then
      SetItem(File(cp.Text).getParentFile())
     elseif 路径.isDirectory() then
      SetItem(路径)
     elseif 路径.isFile() then
      callback(tostring(路径))
      ChoiceFile_dialog.hide()
    end

  end

  SetItem(StartPath)
end


import "android.os.*"


--第一个参数为初始化路径,第二个为回调函数
--他人原创，不知道是谁

function importmd(path,note)
  root_path=Environment.getExternalStorageDirectory().toString().."/monote"
  note=root_path.."/note"
  impathDirFile=File(path)
  activity.newTask(function(impathDirFile,note)
    require "import"
    import "java.io.*"
    fl=luajava.astable(impathDirFile.listFiles())
    table.sort(fl,function(a,b)
      return string.upper(a.Name)<string.upper(b.Name)
    end)
    if pcall(function()------------------------
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
    function Filenm(name)
      return name:match("(.+)%.%w+$")
    end

    function saveNote(path,name,text)
      local tosave_c=string.gsub(text,"%[",":xjszkh:")
      local tosave_c=string.gsub(tosave_c,"%]",":xjsykh:")
      local f,e=pcall(function ()
        io.open(path,"w+"):write([[{
["date"]	={
["create"]	="]]..os.date("%y.%m.%d %H:%M:%S")..[[";
["update"]	="]]..os.date("%y.%m.%d %H:%M:%S")..[[";
};
["content"]	={
["color"]=]].."10086"..[[;
["star"]=]].."false"..[[,
["category"]="]].."导入"..[[";
["title"]	="]]..name..[[";
["messages"]	=]].."[["..tosave_c.."]]"..[[;
};
}]]):close()
      end)
      if not e then
        --print("已保存")
      end
    end

    for index,content in ipairs(fl) do
      if content.isDirectory() then
       else
        likes=(Filesuffix(tostring(content)))
        if likes=="md" or likes=="MD" then
          contents=io.open(tostring(content)):read("*a")
          name=Filenm(tostring(content.getName()))

          --构建目标路径
          wrin=note.."/"..name..index.."_"..os.date("%y%m%d%H")..".".."md"
          --写出文件
          saveNote(wrin,name,contents)
          print("文档导入:"..wrin)
          else
          
        end
      end
    end
    ------------------------
      end) then
     else
    print("不可预料的错误!")
    end------------------------
    return datas
  end
  ,function(datas)
    --打包分享目标路径
    print"导入完毕"
  end).execute({impathDirFile,note})
end
