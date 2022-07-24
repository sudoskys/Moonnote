require "import"

import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"


import "java.io.File"
import"mods.runbase"
import"values.base"

--import"mods.ioshare"
--##################
fav=Environment.getExternalStorageDirectory().toString().."/data"

favwebads=fav.."/time21213.lua"




--no=...

activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)--淡入淡出

activity.setContentView(loadlayout("layout/formal/titlebar"))


activity.ActionBar.hide()--隐藏标题栏


set_flagcolor(to0x(maincolor))

title.setText("时光机")
--进度条
import "android.graphics.PorterDuff"
import "android.graphics.PorterDuffColorFilter"
loadbar.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(to0x(maincolor),PorterDuff.Mode.SRC_ATOP))

loadbar.setVisibility(View.GONE)
nolist.setVisibility(View.GONE)




import "com.androlua.LuaAdapter"
--主界面启动
mainlays.addView(loadlayout(
{
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  layout_height="fill",

  --[
  {
    ListView,
    id="PostList";
    layout_width="fill",
    DividerHeight=0;
    layout_weight="1";
    TranscriptMode="2";
    background="#1F17A8FF";
  },
  {
    CardView;
    layout_width="-1";
    layout_height="-2";
    CardElevation="10dp";
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      {
        EditText;
        id="PostContent";
        layout_height="-1";
        layout_weight="1";
        MaxHeight="190dp";
      };
      {
        LinearLayout;
        layout_width="100dp";
        layout_height="-1";
        gravity="bottom";
        {
          Button;
          id="SendPost";
          text="SEND";
          style="?android:attr/buttonBarButtonStyle";
          layout_height="-2";
          layout_width="-1";
        };
      };
    };
  };
}))

import "layout.talkitem"

--[[

{
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  layout_height="fill",
  {
    ListView,
    id="PostList";
    layout_width="fill",
    DividerHeight=0;
    layout_weight="1";
    TranscriptMode="2";
  },
}
]]


import "android.os.Build"
import "android.graphics.PorterDuffColorFilter"
import "android.widget.EditText"
import "android.graphics.PorterDuff"
import "com.androlua.LuaMultiAdapter"
import "android.widget.Button"
import "android.graphics.drawable.ColorDrawable"
import "android.view.WindowManager"



if Build.VERSION.SDK_INT >= 19 then --根据SDK来设置主题
  if Build.VERSION.SDK_INT >= 21 then
    activity.setTheme(android.R.style.Theme_Material_Light)
   else
    activity.setTheme(android.R.style.Theme_Holo_Light)
  end
end

--activity.ActionBar.setBackgroundDrawable(ColorDrawable(0xff66ccff))  --设置ActionBar的颜色

--print(deread("key202",nil))
function StrToTable(str)
  if str == nil or type(str) ~= "string" then
  end
  return loadstring("return " .. str)()
end

--数据获取
datao={}
File(favwebads).createNewFile()





print((datao))


--activity.setContentView(loadlayout(layout))  --不说 都懂


--print(dump(datao))


PostList.setStackFromBottom(true) --设置列表排序方式
--adp=LuaMultiAdapter(activity,postitem) --创建列表适配器
adp=LuaMultiAdapter(activity,datao,postitem)

PostList.Adapter=adp --给列表穿上适配器


import "android.view.animation.LayoutAnimationController"
import "android.view.animation.AnimationUtils"
animation = AnimationUtils.loadAnimation(activity,android.R.anim.fade_in)
lac=LayoutAnimationController(animation)
lac.setOrder(LayoutAnimationController.ORDER_NORMAL)
lac.setDelay(0.7)--单位是秒
--listView.setAdapter(adp)
PostList.setLayoutAnimation(lac)

--adp.add{__type=3,time=tostring(os.date("%m-%d %H:%M:%S"))} --添加当前时间

function fold()
  if not opp
    opp=Typeface.create(Typeface.DEFAULT, Typeface.BOLD)
  end
  return opp
end

import "android.graphics.*"
function send(name,text)
  adp.add{
    __type=1,
    username="王者",
    usercontent="怎么样，士道君，四糸乃很酷吧，四糸乃很酷吧怎么样，士道君，四糸乃很酷吧，四糸乃很酷吧怎么样，士道君，四糸乃很酷吧，四糸乃很酷吧",
    usrname={Typeface=fold()},
  } --对方发出消息
end

function SendPost.onClick() --发送消息点击事件
  local content=PostContent.text --取要发送的内容
  adp.add{__type=3,
    time=tostring(os.date("%m/%d %H:%M:%S")),
    --time={Typeface=fold()},
  } --先发送当前时间 使用type3
  adp.add{__type=2,
    username="我",
    usercontent=content,
    usrname={Typeface=fold()}
  }--username是自己的昵称  后面一个是发的消息
  content=nil
  PostContent.setText("") --有点脑子就能明白
end

--[[
PostList.onItemLongClick=function(parent,v,pos,id) --列表长按事件
  local items={"回复 "..v.Tag.username.text} --v.Tag.username.text取要回复的人的昵称
  AlertDialog.Builder(this) --创建DiaLog 列表对话框
  .setTitle("列表对话框")
  .setItems(items,{onClick=function(l,vv) --列表点击事件
      if items[vv+1]=="回复 "..v.Tag.username.text then --判断是不是点击的回复xxx
        adp.add{__type=4,reuser="回复:"..v.Tag.username.text,recontent=v.Tag.usercontent.text,username="我要",usercontent=PostContent.text}
        -- adp添加  使用布局4  reuser是回复给谁                  recontent是获取要回复的人说的内容  username是自己的昵称        usercontent是获取了要发送的内容
      end
  end})
  .show()
end
--]]




function array2string(t)
  for k,v in ipairs(t) do
    t[k]=string.format("%q",v)
  end
  return table.concat(t,",\n  ")
end
function onPause()
  --转换成string
  rp=dump(datao)
  print(rp)
  if rp~=nil then
    file=io.open(favwebads,"w+")
    io.output(file)
    io.write((rp))
    io.flush()
    io.close(file)
  end
end
