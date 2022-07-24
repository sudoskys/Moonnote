require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.*"
import "android.net.Uri"
import "android.graphics.*"
import "android.view.animation.AnimationUtils"
import "android.view.animation.LayoutAnimationController"

catkey=(activity.getGlobalData().key)
if catkey and catkey==2021/03/27 then--建议在文件中替换自己的比对key
 else
  print("Running error")
  activity.finish()--关闭当前页面
end
--初始化包
import"webdav"
import"mods.runbase"
import"values.base"
import"mods.ioshare"
--##################
--界面初始化
--no=...
activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)--淡入淡出
activity.setContentView(loadlayout("layout/formal/secondary"))
activity.ActionBar.hide()--隐藏标题栏
set_flagcolor(to0x(maincolor))
title.setText("Webdav")

----数据模块
--自动保存
asave=function(url,pass,account)
  ensave("wdurl",url,function()end)
  ensave("wdpass",pass,function()end)
  ensave("wdaccount",account,function()end)
end



--设置保存
Sideslip.onClick=function()
  asave(serve.Text,password.Text,account.Text)
  activity.finish()--关闭当前页面
end
function onPause()
  asave(serve.Text,password.Text,account.Text)
end
function onStop()
  --asave(serve.Text,password.Text,account.Text)
  if pcall(function()------------------------
      oq.quit()
    end) then
   else
  end
end

--###功能设置###
--加载二级布局
mainlays.addView(loadlayout(
{
  LinearLayout;
  background=backcolor;
  orientation="vertical";
  layout_height="fill";
  layout_width="fill";
  {
    LinearLayout;
    layout_height="24%h";
    layout_width="fill";
    layout_gravity="center";
    gravity="center";
    {
      ImageView;
      layout_height="fill";
      scaleType="centerInside";
      src="drawable/Cloudsync.png";
      layout_width="fill";
    };
  };
  {
    LinearLayout;
    layout_height="38%h";
    layout_gravity="center";
    layout_width="fill";
    gravity="center";
    {
      CardView;
      layout_height="32%h";
      layout_width="90%w";
      CardElevation="0px";
      radius="6dp";
      {
        LinearLayout;
        background=backcolor;
        gravity="center";
        layout_height="fill";
        layout_width="fill";
        orientation="vertical";
        {
          LinearLayout;
          layout_height="8%h";
          layout_width="fill";
          gravity="center";
          {
            ImageView;
            layout_height="25dp";
            layout_width="25dp";
            src="drawable/cloud.png";
            scaleType="fitCenter";
            layout_margin="4dp";
            colorFilter=maincolor;
          };
          {
            EditText;
            layout_width="76%w";
            -- background=backcolor;
            hint="服务器地址";
            singleLine=true;--设置单行输入
            textColor=maincolor;--输入文本的颜色

            id="serve";
          };
        };
        {
          LinearLayout;
          layout_height="8%h";
          layout_width="fill";
          gravity="center";
          {
            ImageView;
            layout_height="25dp";
            layout_width="25dp";
            src="drawable/account.png";
            scaleType="fitCenter";
            layout_margin="4dp";
            colorFilter=maincolor;
          };
          {
            EditText;
            layout_width="76%w";
            -- background=backcolor;
            hint="账号";
            id="account";
            singleLine=true;--设置单行输入
            textColor=maincolor;--输入文本的颜色

          };
        };
        {
          LinearLayout;
          layout_height="8%h";
          layout_width="fill";
          gravity="center";
          {
            ImageView;
            layout_height="25dp";
            layout_width="25dp";
            src="drawable/lock.png";
            scaleType="fitCenter";
            layout_margin="4dp";
            colorFilter=maincolor;
          };
          {
            EditText;
            layout_width="76%w";
            --background=backcolor;
            hint="密码";
            id="password";
            password="true";--显示类型为密码

            singleLine=true;--设置单行输入
            textColor=maincolor;--输入文本的颜色
          };
        };
        {
          LinearLayout;
          layout_height="8%h";
          layout_width="fill";
          gravity="center";
          {
            CardView;
            layout_height="12%w";
            CardElevation="4px";
            background=maincolor;
            layout_width="46%w";
            radius="3dp";
            {
              LinearLayout;
              layout_height="fill";
              layout_width="fill";
              gravity="center";
              id="gosync";
              {
                TextView;
                text="开始同步";
                textSize="18";
                textColor=txtcolor;
              };
            };
          };
        };
      };
    };
  };
  {
    ScrollView,
    id="sr",
    layout_width="fill",
    layout_height="fill",
    {
      LinearLayout,
      layout_width="fill",
      orientation="vertical",

      {
        TextView;
        layout_height="wrap";
        layout_width="fill";
        -- gravity="center";
        id="cont";
      };
    };
  };
}
))

ripples(gosync,to0x(sancolor))
ripples(Sideslip,to0x(sancolor))
password.getBackground().setColorFilter(PorterDuffColorFilter(to0x(maincolor),PorterDuff.Mode.SRC_ATOP));
account.getBackground().setColorFilter(PorterDuffColorFilter(to0x(maincolor),PorterDuff.Mode.SRC_ATOP));
serve.getBackground().setColorFilter(PorterDuffColorFilter(to0x(maincolor),PorterDuff.Mode.SRC_ATOP));
--防止输入法影响布局
--activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)
--使弹出的输入法不影响布局
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);

--加载webdav事件
function check()
  --读取数据
  web=(deread("wdurl",nil))
  key=(deread("wdpass",nil))
  users=(deread("wdaccount",nil))
  if key and users and web then
    account.setText(tostring(users))
    serve.setText(web)
    password.setText(key)
  end
end
check()




--[[
obj.下载数据("测试/test.txt",function(...)
  print(...)
end)
]]


--WebDav(账号,密码) 参数可不填
--服务器(WebDav地址) 用于登录,默认坚果云
--账号(WebDav账号) 用于登录
--密码(WebDav密码) 用于登录
--上传文件(路径,被上传的文件路径,回调事件(状态码,返回值))
--上传数据(路径,字符串数据,回调事件(状态码,返回值))
--下载文件(路径,回调事件(状态码,返回值))
--下载数据(路径,回调事件(状态码,返回值))
--文件列表(目录,回调事件(状态码,返回值))
--删除文件(路径,回调事件(状态码,返回值))

--[[
function sync()
  ac=account.Text
  pa=password.Text
  se=serve.Text
  root_path=Environment.getExternalStorageDirectory().toString().."/monote/"
  import "java.io.*"
  import "webdav"
  obj=WebDav()
  .账号(ac)
  .密码(pa)
  .服务器(se) --用于登录,默认坚果云
  fl=luajava.astable(noteDirFile.listFiles())
  table.sort(fl,function(a,b)
    return string.upper(a.Name)<string.upper(b.Name)
  end)
  if pcall(function()------------------------
      datas={}
      for index,content in ipairs(fl) do
        if content.isDirectory() then
         else
          Thread.sleep(100)--延迟执行
          date=(io.open(tostring(content)):read("*a"))
          name=content.Name
          parent="monote/"
          --print(name)

          obj.上传数据(parent..name,(date),function(...)
            print(...)
          end)

          -- print("同步文档:"..name)
        end
      end

      ------------------------
    end) then
   else
    print("不可预料的错误!")
  end------------------------
  --[
  activity.newTask(function(noteDirFile,notePath,root_path,ac,pa,se)
    require "import"
    import "java.io.*"
    import "webdav"
    obj=WebDav()
    .账号(ac)
    .密码(pa)
    .服务器(se) --用于登录,默认坚果云
    fl=luajava.astable(noteDirFile.listFiles())
    table.sort(fl,function(a,b)
      return string.upper(a.Name)<string.upper(b.Name)
    end)
    if pcall(function()------------------------
        datas={}
        for index,content in ipairs(fl) do
          if content.isDirectory() then
           else
            date=(io.open(tostring(content)):read("*a"))
            name=content.Name
            parent="monote/"
            print(name)
            --obj.上传数据(parent..name,"Hello, World!",function(...)
            --  print(...)
           -- end)
           

            print("文档导出:"..outname)
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


  end).execute({noteDirFile,notePath,root_path,ac,pa,se})

end
--]]
function wrt(path,no)
  import"java.io.File"
  f=File(tostring(File(tostring(path)).getParentFile())).mkdirs()
  io.open(tostring(path),"w"):write(tostring(no)):close()
end
function 退出()
  oq.quit()
  od.hide()
  --  ct=nil
end
function 初始化()
  ac=account.Text
  pa=password.Text
  se=serve.Text
  parent="monote/"
  obj=WebDav()
  .账号(ac)
  .密码(pa)
  .服务器(se) --用于登录,默认坚果云
  return obj
end
获取=function()
  obj=初始化()
  obj.文件列表(parent,function(code,connect)
    activity.getGlobalData()["wdcode"]=tostring(code)
    activity.getGlobalData()["wdconnect"]=tostring(connect)
  end)
end
下载=function(names)
  obj=初始化()
  a=activity.getGlobalData()["davadd"]
  a=parent..names
  obj.下载数据(a,function(code,con)
    if code==200 then
      --构建路径
      path=note..names
      cts=">>-->已下载__"..path.."\n"
      if ct then
        ct=ct..cts
       else
        ct=""
        cont.setText("")
      end
      cont.setText(ct)
      con=con:gsub("|n|","\n")
      -- print(tostring(con))
      wrt(path,con)
     else
      print("下载失败"..code)
      ct=nil
    end
  end)

end
上传=function(content)
  obj=初始化()
  root_path=Environment.getExternalStorageDirectory().toString().."/monote/"
  content=File(content)
  -- print(content)
  --  parent="monote/"
  date=(io.open(tostring(content)):read("*a"))
  date=date:gsub("\n","|n|")
  name=content.Name
  obj.上传数据(parent..name,(date),function(code,some)
    if code==200 then
      cts=(">>-->提交__"..code.."__"..some.."\n")
      if ct then
        ct=ct..cts
       else
        ct=""
        cont.setText("")
      end
      cont.setText(ct)
      --[[
    obj.下载数据(parent..name,function(...)
    --  print(...)
      print(tostring(content))
    end)
  ]]
     else
      print(code.."失败")
      ct=nil
    end
  end)
end
--写一个方法线程
gooo=function(str)
  require "import"
  require "import"
  import "android.app.*"
  import "android.os.*"
  import "android.widget.*"
  import "android.view.*"
  import"mods.runbase"
  import"values.base"

  import "java.io.File"
  fl=luajava.astable(noteDirFile.listFiles())
  table.sort(fl,function(a,b)
    return string.upper(a.Name)<string.upper(b.Name)
  end)
  --  if pcall(function()------------------------
  datas={}
  for index,content in ipairs(fl) do
    -- print(index)
    if content.isDirectory() then
     else
      Thread.sleep(280)--延迟执行
      --print(name)
      call("上传",tostring(content))--调用主线程的"aaa"
      -- print("同步文档:"..name)
    end

  end
  ct=nil
  Thread.sleep(100)--延迟执行
  call("获取","aa")--调用主线程的"aaa"
  Thread.sleep(1000)--延迟执行
  while activity.getGlobalData()["wdcode"] do
    if activity.getGlobalData()["wdcode"]=="200"
      connects=activity.getGlobalData()["wdconnect"]
      function holdname(name)
        return name:match(".+%/(.+)$")
      end
      c=1
      --print(connects)
      --connects=tostring(connect)
      for a in connects:gmatch('(.-)[,|%]]') do
        if c==1 then
          --ol=a
         else
          names=(holdname(tostring(a)))
          Thread.sleep(1000)--延迟执行
          activity.getGlobalData()["davadd"]=tostring(a)
          call("下载",tostring(names))--调用主线程的"aaa"
        end
        c=c+1
      end
     else
      print(activity.getGlobalData()["wdcode"].."失败")
    end
    break
    --activity.getGlobalData()["wdcode"]=nil
  end

  ------------------------
  --      end) then
  print("执行完毕")
  --  ct=nil
  call("退出","a")
  --   else
  --      print("不可预料的错误!")
  --  end------------------------
end
--设置按钮事件
import "android.app.ProgressDialog"
import "java.lang.Thread"
import "android.graphics.PorterDuffColorFilter"
import "android.widget.EditText"
gosync.onClick=function()
  asave(serve.Text,password.Text,account.Text)
  ct=nil
  od= ProgressDialog.show(this, "提示", "正在同步",false,false)
  --sync()
  oq=thread(gooo,100)
  task(150000,function()--1000毫秒=1秒
    od.hide()
  end)
end