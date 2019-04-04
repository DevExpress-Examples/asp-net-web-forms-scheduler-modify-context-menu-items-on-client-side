<!-- default file list -->
*Files to look at*:

* [CustomDataSource.cs](./CS/WebSite/CustomDataSource.cs) (VB: [CustomDataSource.vb](./VB/WebSite/CustomDataSource.vb))
* [CustomObjects.cs](./CS/WebSite/CustomObjects.cs) (VB: [CustomObjects.vb](./VB/WebSite/CustomObjects.vb))
* [Default.aspx](./CS/WebSite/Default.aspx) (VB: [Default.aspx](./VB/WebSite/Default.aspx))
* [Default.aspx.cs](./CS/WebSite/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/WebSite/Default.aspx.vb))
<!-- default file list end -->
# How to modify the availability/visibility of context menu items on the client side


<p>In some scenarios you need to change availability/visibility of some context menu items in depending on selected appointment properties.</p>
<p>Since ASPxScheduler.PopupMenuShowing is a server-side event and is raised only before the PopupMenu is generated during a postback/callback request, the mentioned behavior can't be implemented in this event handler.</p>
<p>This behavior should be implemented in the client-side <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxMenuScriptsASPxClientMenuBase_PopUptopic"><u>ASPxClientMenu.PopUp</u></a> event handler.</p>
<p>This example demonstrates how to achieve it.</p>

<br/>


