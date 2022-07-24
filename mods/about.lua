
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
import "java.io.File"
import "com.androlua.LuaUtil"
import "android.content.res.ColorStateList"

maincolor=...

catkey=(activity.getGlobalData().key)
if catkey and catkey==2021/03/27 then--建议在文件中替换自己的比对key
 else
  print("Running error")
  activity.finish()--关闭当前页面
end
activity.ActionBar.hide()--隐藏标题栏

import"values.base"
import"mods.runbase"


activity.setContentView(loadlayout("layout/about"))--设置窗口视图


activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)--淡入淡出
--activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xFF56B2DB)
set_flagcolor(to0x(maincolor))

import"mods.saveout"
import"mods.importin"


Sideslip.onClick=function()
  activity.finish()--关闭当前页面
end


packinfo =
this.getPackageManager().getPackageInfo(
this.getPackageName(),
((32552732 / 2 / 2 - 8183) / 10000 - 6 - 231) / 9
)
bben = tostring(packinfo.versionName)

function 中部提示(info)
  sth=tostring(info)
  body={
    CardView;
    CardBackgroundColor="#C0000000";
    elevation="0dp";
    -- layout_width="95%w";
    layout_height="42dp";
    radius="18dp";
    id="Toastbody";
    {
      TextView;
      textSize="15sp";
      TextColor="#FFffffff";
      layout_width="45%w";
      layout_height="42dp";
      gravity="center";
      text="出错";
      id="Toastmessage";
    };
  }
  local Toastbody=Toast.makeText(activity,"内容",Toast.LENGTH_SHORT).setView(loadlayout(body))
  Toastbody.setGravity(Gravity.CENTER,0,60)
  Toastmessage.Text=tostring(sth)
  Toastbody.show()
  return Toastbody
end


function FakeBoldText(ID)
  if pcall(function()
      import "android.graphics.Paint"
      ID.getPaint().setFakeBoldText(true)
    end) then
   else
    print"字体粗化设置出错"
  end
end

function setbitmap(ID,address)
  if pcall(function()
      address=tostring(address)
      ID.setImageBitmap(loadbitmap(address))
    end) then
   else
    -- print"图片设置错误"
  end
end
--写入数据函数
function putData(name,key,value)
  this.getApplicationContext().getSharedPreferences(name,0).edit().putString(key,value).apply()--3255-2732
  return true
end

function getData(name,key)--验证
  local data=this.getApplicationContext().getSharedPreferences(name,0).getString(key,nil)--325-5273-2
  return data
end

ripples(Sideslip,to0x(txtcolor))
FakeBoldText(other_title)
FakeBoldText(Developer_title)
FakeBoldText(set_title)


Developer_name01.setText("洛樱")
Developer_info01.setText("应用开发")
title.setText("关于  "..bben)




setbitmap(Developer_01,"https://i0.hdslb.com/bfs/face/7865ed1e1a9bb699ebed3838b81cda09b0655f8e.jpg")


saveout.onClick=function()
  saveouts()
end




function 监听开关(ID,path)
  --启动模式选择监听
  if pcall(function()
      path=tostring(path)
      ID.setOnCheckedChangeListener{
        onCheckedChanged=function(g,c)
          if c==true then
            putData("switch",path,"true")
            --   io.open(path,"w+"):write("true"):close()
           else
            -- io.open(path,"w+"):write("false"):close()
            putData("switch",path,"false")
          end
      end}
      if getData("switch",path)=="true" then
        ID.setChecked(true)
       else
        ID.setChecked(false)
      end
    end) then
   else
    print("请开放存储权限")
  end
end
function 设置开关颜色(ID,Groove,Keys)
  if pcall(function()
      ID.ThumbDrawable.setColorFilter(PorterDuffColorFilter(Groove,PorterDuff.Mode.SRC_ATOP))
      ID.TrackDrawable.setColorFilter(PorterDuffColorFilter(Keys,PorterDuff.Mode.SRC_ATOP))
    end) then else
    print("按钮颜色设置错误")
  end
end


监听开关(issave,"是否保存")
监听开关(ispubu,"是否瀑布")
设置开关颜色(issave,0xFF74AAFF,0xDA0E45A0)
设置开关颜色(ispubu,0xFF74AAFF,0xDA0E45A0)



开源.onClick=function()
  activity.newActivity("action/git")
end

反馈.onClick=function()
  activity.newActivity("action/post")
end

隐私.onClick=function()
  selectd=0
  activity.newActivity("mods/agree",{selectd})
end
协议.onClick=function()
  selectd=1
  activity.newActivity("mods/agree",{selectd})
end

importins.onClick=function()
  ChoicePath(Environment.getExternalStorageDirectory().toString(),
  function(path,note)
    --print(path)
    task(200,function()
      importmd(path,note)
    end)
  end)
end

Webdavup.onClick=function()
  --selectd=1
  activity.newActivity("mods/Wdup",{})
end