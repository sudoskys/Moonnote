--基本
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--导入graphics类
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.Color"
import "android.graphics.PorterDuff"
import "android.content.res.ColorStateList"
import "android.support.v4.widget.*"
import "android.view.animation.AnimationUtils"
import "android.view.animation.LayoutAnimationController"

import "android.content.res.ColorStateList"

activity.setTitle('月笔记')


--导入所需函数库
import"values.base"
import"layout.home"
import"mods.runbase"
import"mods.home_runs"


import "android.content.Context"
import "android.net.ConnectivityManager"
se="https://gitee.com/luo-ying2020/STUDY_mys/raw/master/".."monote/upda.md"
es="http://hub.fastgit.org/luoying2024/Sakura-animation/raw/master/".."monote/upda.md"
--https://github.com/
检测更新(se,es)

--检测更新("https://wds.ecsxs.com/206855.html")


--导入高级包
import "com.dingyi.dialog.BottomDialog"
md=require "mods.luaMarkdown"

--检查自身
if pcall(function()
    localObject = ClassLoader.getSystemClassLoader().loadClass("de.robv.android.xposed.XposedHelpers").newInstance()
  end) then
  activity.finish()
  os.exit()
end
if activity.getPackageName() == "com.luoying.notebook" then
 else
  --os.execute("rm -r /data/data/" .. activity.getPackageName() .. "/files/")
  --File("/data/data/" .. activity.getPackageName() .. "/files/").createNewFile()
  poToast(":( Configuration_error..盗版警告")
  --os.exit()--每次都要记得改
end

--隐藏ActionBar
activity.ActionBar.hide()--隐藏标题栏

--After checking, start loading layout.
set_flagcolor(to0x(maincolor))
activity.setContentView(loadlayout("layout/home"))

--Set the progress color
Pro1.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(to0x(subcolor),PorterDuff.Mode.SRC_ATOP))


--Drop-down refresh is removed, so sr monitoring is commented out
--[[
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    Refresh()
    sr.setRefreshing(false);
end})
sr.setColorSchemeColors({0xFF74AAFF});
--]]


if getData("luoying","shoulder")=="true" then
 else
  --  print(getData("luoying","shoulder"))
  pass()
end
if LuaApplication ~= LuaApplication.getInstance().getClass() then
  poToast(":( LuaApplication.class_error")
  activity.finish()
end
--导入主页布局选择器
import"values.homesele"

--[[
mainlays.addView(loadlayout ( {
  ListView;
  dividerHeight="0";
  layout_width="fill";
  background=backcolor;
  layout_height="fill";
  id="notelist";
}))
]]




--[[
notelist.onItemLongClick=function(l, v, d, p)
  --dele.show()
  --redialog.dismiss()
end
notelist.onItemClick=function(l, v, d, p)
  local titles=datas[p].date
  local texts=datas[p].textto
  local types=datas[p].likes
  local roadt=datas[p].roads
  --print(roadt)
  redialog.show()
  redialog.setCanceledOnTouchOutside(true);--设置触摸弹窗外部隐藏弹窗
  reviewmd.loadDataWithBaseURL("",md(texts),"text/html","utf-8",nil)
  retitle.setText(titles)
  retitle.setTextColor(to0x(maincolor))

  FakeBold(retitle)

  deletep.setColorFilter(to0x(subcolor))
  editp.setColorFilter(to0x(subcolor))
  sharep.setColorFilter(to0x(subcolor))

  ripples(edits,to0x(subcolor))
  ripples(shares,to0x(subcolor))
  ripples(delete,to0x(subcolor))

  edits.onClick=function()
    this.newActivity("mods/edit",{roadt})
    redialog.dismiss()
  end
  shares.onClick=function()
    shareText(StrToTable(io.open(roadt):read("*a"))["content"]["title"].."\n\n"..StrToTable(io.open(roadt):read("*a"))["content"]["messages"])
  end
  delete.onClick=function()
    deles(roadt)
    redialog.dismiss()
  end
end

]]

--删除弹窗
function deles(roadt)
  dele=AlertDialog.Builder(this)
  dele.setTitle("提示")
  dele.setMessage("是否删除此文档，不可找回")
  dele.setNeutralButton("确定",{onClick=function(v)
      activity.newTask(function(roadt)
        require "import"
        import "java.io.File"
        this.update("正在删除文件")
        return File(tostring(roadt)).delete()
      end
      ,function(info)
        showLoadingDia(info)
      end
      ,function(succeed,exit,num)
        Refresh()
        closeLoadingDia()
        executeState2Toast(succeed,exit,num,"删除")
      end).execute({roadt})
  end})
  dele.setPositiveButton("取消",nil)
  --dele.setNegativeButton("否认",nil)
  dele.show()
end
--弹窗布局
local putout={
  LinearLayout;
  layout_height="50%h";
  orientation="horizontal";
  {
    LinearLayout;
    background="#ffffffff";
    layout_width="fill";
    layout_height=(activity.getHeight()*0.5);
    id="dia";
    orientation="vertical";
    {
      LinearLayout;
      layout_margin="6dp";
      layout_width="fill";
      layout_height="38dp";
      {
        TextView;
        text="标题是这样的";
        layout_height="fill";
        layout_width="50%w";
        textSize="18";
        singleLine="true";
        gravity="left|center";
        id="retitle";
        layout_marginLeft="10dp";
      };
      {
        LinearLayout;
        layout_width="fill";
        layout_height="fill";
        gravity="end";

        {
          LinearLayout;
          layout_height="fill";
          gravity="center";
          id="delete";
          layout_marginRight="20dp";
          {
            ImageView;
            --scaleType="centerInside";
            layout_width="25dp";
            layout_height="25dp";
            src="drawable/delete.png";
            layout_margin="4dp";
            colorFilter=miancolor;
            id="deletep";
          };
        };

        {
          LinearLayout;
          layout_height="fill";
          gravity="center";
          id="shares";
          layout_marginRight="20dp";
          {
            ImageView;
            --scaleType="centerInside";
            layout_width="25dp";
            layout_height="25dp";
            src="drawable/share.png";
            layout_margin="4dp";
            colorFilter=miancolor;
            id="sharep";
          };
        };
        {
          LinearLayout;
          layout_height="fill";
          gravity="center";
          id="edits";
          {
            ImageView;
            --scaleType="centerInside";
            layout_width="25dp";
            layout_height="25dp";
            src="drawable/edit.png";
            layout_margin="4dp";
            colorFilter=miancolor;
            id="editp";
          };
        };
      };
    };
    {
      LinearLayout;
      layout_margin="0dp";
      layout_width="fill";
      layout_height="fill";
      {
        LuaWebView;
        id="reviewmd";
        layout_height="fill";
        layout_width="fill";
      };
    };
  };
};



--创建Dialog弹窗
redialog=BottomDialog(activity)--R.style.BottomDialog)
--设置弹窗布局
redialog.setView(loadlayout(putout))
--设置弹窗位置
redialog.setGravity(Gravity.BOTTOM)
--设置弹窗高度,宽度，最低高度
redialog.setHeight(activity.getHeight()*0.6)
redialog.setMinHeight(activity.getHeight()*0.3)
redialog.setWidth(activity.getWidth())
--设置圆角
redialog.setRadius(20,0xffffffff)

sets.onClick=function()
-- activity.newActivity("mods/about")--跳转页面
activity.newActivity("action/sett")--跳转页面

end



search.onClick=function()
  Refresh()
  local function 圆角(控件,背景色,角度)
    import "android.app.AlertDialog"
    import "android.graphics.drawable.GradientDrawable"
    local gd=GradientDrawable()
    .setShape(GradientDrawable.RECTANGLE)
    .setColor(背景色)
    .setCornerRadii(角度)
    if 控件 then
      控件.setBackgroundDrawable(gd)
    end
    return gd
  end

  InputLayout={
    ScrollView,
    { LinearLayout;
      layout_width="fill";
      orientation="vertical";
      { EditText;
        hint=" 输入关键词";
        layout_width="80%w";
        layout_gravity="center",
        layout_margin="14dp";
        text=el;
        id="edit";
        imeOptions="actionGo"
      };
    };
  };
  se=AlertDialog.Builder(this).setView(loadlayout(InputLayout))
  se.setPositiveButton("搜索",{onClick=function(v)
      searchtxt(edit.text)
  end})
  se.setNegativeButton("取消",nil)
  ses=se.show()
  圆角(ses.getWindow(),0xfffafafa,{25,25,25,25,25,25,25,25})
  --searchtxt("喵")
end


items={}
table.insert(items,"新建记事文档")
table.insert(items,"新建代码文档")
table.insert(items,"从剪切板导入")
table.insert(items,"取消操作")
--列表对话框
selects=AlertDialog.Builder(this)
selects.setTitle("选择类型")
selects.setItems(items,{onClick=function(l,v)
    if (items[v+1])=="新建记事文档" then
      newNote("md",note)
    end
    if (items[v+1])=="新建代码文档" then
      newNote("lua",note)
    end
    if (items[v+1])=="从剪切板导入" then
      translateNote("md",note)
    end
end})

newone.onClick=function()
  selects.show()
end

title.onClick=function()
  --     activity.newActivity("mods/talk")--跳转页面
end

function onResume()
  Refresh()
end


ripples(newone,to0x(subcolor))
ripples(search,to0x(sancolor))
ripples(sets,to0x(sancolor))
ripples(title,to0x(sancolor))

