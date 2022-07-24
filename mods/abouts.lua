
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
local lays={
  LinearLayout;
  layout_width="fill";
  layout_height="fill";
  orientation="vertical";
  {
    LinearLayout;
    layout_width="fill";
    id="status_bar";
    background=maincolor;
    elevation="2dp";
  };
  {
    LinearLayout;
    layout_height="54dp";
    elevation="2dp";
    layout_width="fill";
    -- orientation="vertical";
    background=maincolor;
    {
      LinearLayout;
      layout_width="55dp";
      layout_height="55dp";
      id="Sideslip";
      gravity="center";
      {
        ImageView;
        src="drawable/back.png";
        layout_height="28dp";
        layout_width="25dp";
        colorFilter=imagecolor;
      };
    };
    {
      LinearLayout;
      layout_height="fill";
      orientation="horizontal";
      layout_weight="1";
      {
        TextView;
        text="关于";
        textSize="22sp";
        textColor=txtcolor;
        id="title";
        layout_gravity="center";
      };
    };
  };
  {
    LinearLayout;
    layout_width="fill";
    orientation="vertical";
    layout_height="fill";
    id="主框架";
    {
      ScrollView;
      layout_width="fill";
      layout_height="fill";
      backgroundColor=backcolor;
      verticalScrollBarEnabled=false,--隐藏纵向滑条

      {
        LinearLayout;
        layout_width="fill";
        orientation="vertical";
        layout_height="fill";
        id="滑动框架";
        {
          CardView;
          layout_margin="7dp";
          radius="5dp";
          layout_height="wrap";
          elevation="2dp";
          layout_width="fill";
          id="介绍卡片";
          CardBackgroundColor="#ffffffff";
          layout_marginTop="10dp";
          {
            LinearLayout;
            layout_width="fill";
            layout_height="fill";
            orientation="vertical";
            {
              ImageView;
              src="drawable/code.png";
              scaleType="centerInside";
              layout_width="fill";
              id="介绍卡片_图片";
              layout_height="40%w";
              layout_margin="5dp";
            };
            {
              LinearLayout;
              layout_width="fill";
              layout_height="wrap";
              gravity="right";
              {
                TextView;
                layout_margin="6dp";
                text=[==[本应用仍在继续完善...
                
]==];
                textSize="12sp";
                layout_height="wrap";
                layout_width="80%w";
                textColor="#FF8A8A8A";
                layout_gravity="right";
                gravity="end";
              };
            };
          };
        };
        {
          CardView;
          layout_margin="7dp";
          layout_height="wrap";
          elevation="2dp";
          layout_width="fill";
          CardBackgroundColor="#ffffffff";
          radius="5dp";
          layout_marginTop="10dp";
          {
            LinearLayout;
            layout_width="fill";
            orientation="vertical";
            layout_height="wrap";
            backgroundColor="#ffffffff";
            {
              TextView;
              layout_height="45dp";
              textSize="15sp";
              text="开发者";
              id="Developer_title";
              layout_width="fill";
              textColor="#FF56B2DB";
              gravity="left|center";
              layout_marginLeft="10dp";
            };
            {
              LinearLayout;
              layout_width="fill";
              orientation="horizontal";
              layout_height="wrap";



              {
                LinearLayout;
                layout_width="fill";
                orientation="vertical";
                layout_height="wrap";
                backgroundColor="#ffffffff";

                {
                  LinearLayout;
                  layout_height="wrap";
                  layout_width="fill";
                  orientation="horizontal";
                  id="Developer02";
                  backgroundColor="#ffffffff";
                  {
                    CircleImageView;
                    layout_margin="10dp";
                    layout_height="40dp";
                    layout_gravity="center";
                    id="Developer_01";
                    layout_width="40dp";
                  };
                  {
                    LinearLayout;
                    layout_gravity="center";
                    layout_height="wrap";
                    layout_width="fill";
                    orientation="vertical";
                    {
                      TextView;
                      textColor="#F5141414";
                      text="洛樱";
                      textSize="16";
                      id="Developer_name01";
                    };
                    {
                      TextView;
                      id="Developer_info01";
                      text="丢失";
                    };
                  };
                };
              };
            };






          };
        };



        {
          CardView;
          layout_margin="7dp";
          layout_height="wrap";
          elevation="2dp";
          layout_width="fill";
          CardBackgroundColor="#ffffffff";
          radius="5dp";
          layout_marginTop="10dp";
          {
            LinearLayout;
            layout_width="fill";
            orientation="vertical";
            layout_height="wrap";
            backgroundColor="#ffffffff";
            {
              TextView;
              layout_height="45dp";
              textSize="15sp";
              text="其他";
              id="other_title";
              layout_width="fill";
              textColor="#FF56B2DB";
              gravity="left|center";
              layout_marginLeft="10dp";
            };


            {
              LinearLayout;
              layout_width="fill";
              orientation="horizontal";
              layout_height="wrap";
              {
                LinearLayout;
                layout_width="15%w";
                layout_height="15%w";
                gravity="center";
                {
                  ImageView;
                  layout_width="28dp";
                  layout_height="28dp";
                  src="drawable/codes.png";
                };
              };
              {
                TextView;
                layout_margin="1dp";
                text="开源使用";
                textSize="16sp";
                textColor="#FF222222";
                style="?android:attr/buttonBarButtonStyle";
                layout_width="fill";
                id="开源";
                layout_height="fill";
                gravity="top";
                layout_marginTop='4dp';
              };
            };
            {
              LinearLayout;
              layout_width="fill";
              orientation="horizontal";
              layout_height="wrap";
              {
                LinearLayout;
                layout_width="15%w";
                layout_height="15%w";
                gravity="center";
                {
                  ImageView;
                  layout_width="28dp";
                  layout_height="28dp";
                  src="drawable/email.png";
                };
              };
              {
                TextView;
                layout_margin="1dp";
                text="反馈问题";
                textSize="16sp";
                textColor="#FF222222";
                style="?android:attr/buttonBarButtonStyle";
                layout_width="fill";
                id="反馈";
                layout_height="fill";
                -- layout_marginTop='4dp';
                gravity="top";
              };
            };
          };
        };
        --{
        --CardView;
        --};

        {
          LinearLayout;
          layout_width="fill";
          orientation="horizontal";
          gravity="center";
          layout_height="40dp";
          {
            TextView;
            text="隐私政策";
            textSize="14sp";
            textColor=subcolor;
            id="隐私";
            layout_gravity="center";
            layout_margin="10dp";
          };
          {
            TextView;
            text="用户协议";
            textSize="14sp";
            textColor=subcolor;
            id="协议";
            layout_gravity="center";
            layout_margin="10dp";
          };
        };



      };
    };
  };
};

activity.setContentView(loadlayout(lays))--设置窗口视图


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


local function FakeBoldText(ID)
  if pcall(function()
      import "android.graphics.Paint"
      ID.getPaint().setFakeBoldText(true)
    end) then
   else
    print"字体粗化设置出错"
  end
end

local function setbitmap(ID,address)
  if pcall(function()
      address=tostring(address)
      ID.setImageBitmap(loadbitmap(address))
    end) then
   else
    -- print"图片设置错误"
  end
end
--写入数据函数
local function putData(name,key,value)
  this.getApplicationContext().getSharedPreferences(name,0).edit().putString(key,value).apply()--3255-2732
  return true
end

local function getData(name,key)--验证
  local data=this.getApplicationContext().getSharedPreferences(name,0).getString(key,nil)--325-5273-2
  return data
end

ripples(Sideslip,to0x(txtcolor))
FakeBoldText(other_title)
FakeBoldText(Developer_title)


Developer_name01.setText("洛樱")
Developer_info01.setText("应用开发")
title.setText("关于  "..bben)




setbitmap(Developer_01,"https://i0.hdslb.com/bfs/face/7865ed1e1a9bb699ebed3838b81cda09b0655f8e.jpg")








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