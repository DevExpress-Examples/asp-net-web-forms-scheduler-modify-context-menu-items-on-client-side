# How to modify the availability/visibility of context menu items on the client side


<p>In some scenarios you need to change availability/visibility of some context menu items in depending on selected appointment properties.</p>
<p>Since ASPxScheduler.PopupMenuShowing is a server-side event and is raised only before the PopupMenu is generated during a postback/callback request, the mentioned behavior can't be implemented in this event handler.</p>
<p>This behavior should be implemented in the client-side <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxMenuScriptsASPxClientMenuBase_PopUptopic"><u>ASPxClientMenu.PopUp</u></a> event handler.</p>
<p>This example demonstrates how to achieve it.</p>

<br/>


