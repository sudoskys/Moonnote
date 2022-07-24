--github@sudoskys
require"import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import"mods.runbase"
import"values.base"
activity.setTitle('隐私页面')

activity.ActionBar.hide()--隐藏标题栏

md=require "mods.luaMarkdown"

activity.overridePendingTransition(android.R.anim.slide_in_left,android.R.anim.fade_out)
set_flagcolor(to0x(maincolor))

selectd=...

local layouts={
  RelativeLayout;
  layout_width="-1";
  background=backcolor;
  layout_height="-1";

  {
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    orientation="vertical";

    {
      LinearLayout;
      layout_width="-1";
      layout_height="-2";
      elevation="0";
      background=maincolor;
      orientation="vertical";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="56dp";
        gravity="center|left";
        {
          LinearLayout;
          orientation="horizontal";
          layout_height="56dp";
          layout_width="56dp";
          id="back";
          gravity="center";

          {
            ImageView;
            ColorFilter=txtcolor;
            src="drawable/back.png";
            layout_height="32dp";
            layout_width="32dp";
            padding="4dp";

          };
        };
        {
          TextView;
          textColor=txtcolor;
          id="title";
          paddingLeft="16dp";
          textSize="20sp";
          layout_height="-2";
          layout_width="-2";

        };
      };
    };
    {
      LinearLayout;
      layout_width="fill";
      layout_height="fill";
      Orientation="vertical";


      {
        LuaWebView;
        id="WebViews";
      };

    };

  };
};

activity.setContentView(loadlayout(layouts))


ripples(back,to0x(txtcolor))
back.onClick=function()
  activity.finish()--关闭当前页面
end

if selectd==1 then
  title.setText("软件使用许可协议")
 local data1=md[[
  **条款和条件**

下载或使用该应用程序，此条款将自动适用于您——因此，请确保在使用该应用程序之前仔细阅读这些条款。您不得以任何方式复制或修改该应用程序、应用程序的任何部分及我的商标。您无权尝试提取应用程序的源代码，也不应尝试将应用程序翻译成其他语言或制作派生版本。该应用程序本身以及与之相关的所有商标、版权、数据库权利和其他知识产权，仍属于luoying.

luoying致力于确保该应用程序尽可能有用和高效。因此，我保留随时对应用程序进行更改或对其服务收费的权利。如果没有向您明确说明您支付的费用，我永远不会向您收取应用程序或其服务费用。

月笔记存储并处理您提供给我的个人数据，以便提供我的服务。确保您的手机和对应用程序的访问安全是您的责任。因此，我建议您不要给您的手机越狱或root您的手机，这是删除软件限制和设备官方操作系统所施加的限制的过程。它可能会使您的手机容易受到恶意软件/病毒/恶意程序的攻击，从而损害您手机的安全功能，并且可能意味着月笔记无法正常运行或根本无法运行。

您应该意识到，luoying在某些情况下不承担任何责任。应用程序的某些功能要求应用程序具有活动的internet连接。连接可以是Wi-Fi，也可以由您的移动网络提供商提供，但如果您无法访问Wi-Fi，并且您没有任何剩余的数据空间，则luoying无法对应用程序无法完全正常工作承担责任。

如果您在Wi-Fi区域外使用该应用程序，您应该记住，您与移动网络提供商的协议条款仍然适用。因此，您的移动提供商可能会向您收取访问应用程序时连接期间的数据成本或其他第三方费用。在使用该应用程序时，您将承担任何此类费用，包括漫游数据费用，前提是您在不关闭数据漫游的情况下在您的母国（即地区或国家）之外使用该应用程序。如果您不是正在使用应用程序的设备的付款人，请注意，我假设您已收到付款人使用该应用程序的许可。

同样，luoying也不能总是对你使用应用程序的方式负责，也就是说，你需要确保你的设备保持充电状态——如果电池用完了，你不能打开它来使用服务，luoying不能承担责任。

关于luoying对您使用该应用程序的责任，当您使用该应用程序时，请务必记住，尽管我努力确保它在任何时候都是更新和正确运行的，但我依赖第三方向我提供信息，以便我可以向您提供信息。luoying对于您因完全依赖应用程序的此功能而遭受的任何直接或间接损失，概不负责。

在某个时候，我可能希望更新应用程序。应用程序的需求可能会发生变化，并且如果您想继续使用该应用程序，则需要下载更新。 luoying不保证应用程序将始终更新，使其与您相关和或与您设备上安装的版本可以使用。但是，您保证在提供给您时始终接受该应用程序的更新。我也可能停止提供该应用程序，并且可以在不通知您终止的情况下随时终止其使用。除非我另行告知，否则在任何终止后，（a）这些条款授予您的权利和许可将终止；（b）您必须停止使用该应用程序，并且（如果需要）将其从设备中删除。

**本条款和条件的变更**

我可能会不时更新我的条款和条件。因此，建议您定期查看此页以了解更改。如有任何更改，我会在本页公布新的条款和条件。

这些条款和条件自2021-04-09起生效。

**联系我们**

如果您对我的隐私政策有任何疑问或建议，请随时通过xiaow3493@gmail.com 与我联系。

此条款和条件页面是由 应用隐私政策生成器_https://app.mukapp.top/ppg/ 生成的。
  

]]
  WebViews.loadDataWithBaseURL("",data1,"text/html","utf-8",nil)
 else
  title.setText("隐私政策")
 local data0=md[[
  
**隐私政策**

luoying开发了该免费的应用程序月笔记。该服务由luoying提供，旨在安装并使用。

我对您使用月笔记的隐私政策做出规定，并解释了我如何收集，保护和披露您因使用我的服务而产生的信息。

如果您选择使用我提供的服务，则表示您同意收集和使用与此政策相关的信息。我收集的个人信息用于提供和改进服务。除非本隐私政策中另有说明，否则我不会与任何人一起使用或分享您的信息。

除非本隐私政策另有规定，否则本隐私政策中使用的术语与我们的条款和条件具有相同的含义，可在月笔记中访问。

**信息收集与使用**

为了获得更好的体验，在使用我们的服务时，我可能会要求您向我们提供某些个人身份信息，包括但不限于用户在线数据. 我请求的信息将保留在您的设备上，不会被我以任何方式收集。

**记录数据**

当您使用我的服务时，如果应用程序出现错误，我会通过第三方数据统计在您的手机上收集数据和信息。该日志数据可能包含以下信息，例如：您的设备Internet协议（ IP）地址，设备名称，操作系统版本，使用我的服务时应用的配置，您使用该服务的时间和日期以及其他统计信息。

**Cookies**

Cookies是具有少量数据的文件，通常用作匿名唯一标识符。 这些信息将从您访问的网站发送到浏览器，并存储在设备的内存中。

本应用未明确使用这些Cookies。但是，该应用程序可能使用第三方代码和使用带有Cookies的库来收集信息并改善其服务。 您可以选择接受还是拒绝这些Cookies，并知道何时将Cookies发送到您的设备。 如果您选择拒绝我们的Cookies，则可能无法使用本服务的部分功能。

**服务供应商**

我可能由于以下原因雇用第三方公司和个人：

*   促进我们的服务质量；
*   代表我们提供服务；
*   提供与服务相关的服务；
*   帮助我们分析如何使用我们的服务。

我想通知此服务的用户，这些第三方有权访问您的个人信息。原因是代表我们执行分配给他们的任务。但是，他们有义务不出于任何其他目的披露或使用该信息。

**安全**

我很重视您对我们提供您的个人信息的信任，因此我们正在努力使用商业上可接受的方法来保护它。但是请记住，没有一种通过互联网传输的方法，或者说电子存储的方法是100%安全可靠的，我不能保证它的绝对安全性。

**到其他网站的链接**

此服务可能包含指向其他网站的链接。如果你点击第三方链接，你将被引导到该网站。注意，这些外部站点不是由我操作的。因此，我强烈建议您查看这些网站的隐私策略。我对任何第三方网站或服务的内容、隐私政策或做法没有控制权，也不承担任何责任。

**儿童隐私**

这些服务不面向13岁以下的青少年。我不会有意收集13岁以下儿童的个人身份信息。如果我发现13岁以下的儿童向我提供了个人信息，我会立即从我们的服务器中删除这些信息。 如果您是父母或监护人，并且知道您的孩子向我提供了个人信息，请与我联系，以便我能够采取必要的措施。

**本隐私政策的变更**

我可能会不时更新我们的隐私政策。因此，建议您定期查看此页以了解更改。如有任何更改，我会在本页公布新的隐私政策。

该政策自2021-04-09起生效。

**联系我们**

如果您对我的隐私政策有任何疑问或建议，请随时通过xiaow3493@gmail.com与我联系。

此隐私政策页面是在 privacypolicytemplate.net 创建的，并由 应用隐私政策生成器_https://app.mukapp.top/ppg/ 生成。
  
 ]]
  WebViews.loadDataWithBaseURL("",data0,"text/html","utf-8",nil)




end

