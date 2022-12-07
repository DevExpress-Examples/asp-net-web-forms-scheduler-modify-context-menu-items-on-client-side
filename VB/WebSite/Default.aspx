<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="WebApplication1.Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v15.1, Version=15.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.XtraScheduler.v15.1.Core, Version=15.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraScheduler" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
</head>
<body>
	<script lang="cs">
		function OnClientPopupMenuShowing(s, e) {
			var selectedApptIDs = MainSchedulerControl.GetSelectedAppointmentIds();
			if (selectedApptIDs.length > 0) {
				var selectedAppointment = MainSchedulerControl.GetAppointmentById(MainSchedulerControl.GetSelectedAppointmentIds()[0]);
				var apptSubject = selectedAppointment.subject;
				var apptStatus = selectedAppointment.statusIndex;
				for (menuItemId in e.item.items) {
					if (e.item.items[menuItemId].name == "OpenAppointment") {
						e.item.items[menuItemId].SetEnabled(apptSubject.indexOf("meeting") >= 0 || apptStatus == 1);
					}
					if (e.item.items[menuItemId].name == "DeleteAppointment") {
						e.item.items[menuItemId].SetVisible(apptStatus > 1);
					}
				}
			}
		}
	</script>
	<form id="form1" runat="server">
		<div>
			<dxwschs:ASPxScheduler ID="ASPxScheduler1" runat="server" AppointmentDataSourceID="ObjectDataSourceAppointment" ClientIDMode="AutoID"
				ClientInstanceName="MainSchedulerControl" 
				Start="2013-10-30" GroupType="Date" ResourceDataSourceID="ObjectDataSourceResources" OnPopupMenuShowing="ASPxScheduler1_PopupMenuShowing" OnInitClientAppointment="ASPxScheduler1_InitClientAppointment">
				<Storage>
					<Appointments AutoRetrieveId="True">
						<Mappings 
							AllDay="AllDay" 
							AppointmentId="Id" 
							Description="Description" 
							End="EndTime" 
							Label="Label" 
							Location="Location" 
							RecurrenceInfo="RecurrenceInfo" 
							ReminderInfo="ReminderInfo" 
							ResourceId="OwnerId" 
							Start="StartTime" 
							Status="Status" 
							Subject="Subject" 
							Type="EventType" />
					</Appointments>
					<Resources>
						<Mappings 
							Caption="Name" 
							ResourceId="ResID" />
					</Resources>
				</Storage>

				<Views>
					<DayView>
						<TimeRulers>
							<cc1:TimeRuler></cc1:TimeRuler>
						</TimeRulers>
						<DayViewStyles ScrollAreaHeight="600px">
						</DayViewStyles>
					</DayView>

					<WorkWeekView>
						<TimeRulers>
							<cc1:TimeRuler></cc1:TimeRuler>
						</TimeRulers>
					</WorkWeekView>
				</Views>
			</dxwschs:ASPxScheduler>
			<br />
			<br />
			<asp:Button ID="ButtonPostBack" runat="server" Text="Post Back" />

			<asp:HiddenField ID="HiddenFieldResourceId" runat="server" />

			<asp:ObjectDataSource ID="ObjectDataSourceResources" runat="server" OnObjectCreated="ObjectDataSourceResources_ObjectCreated" SelectMethod="SelectMethodHandler" TypeName="WebApplication1.CustomResourceDataSource"></asp:ObjectDataSource>
			<asp:ObjectDataSource ID="ObjectDataSourceAppointment" runat="server" DataObjectTypeName="WebApplication1.CustomAppointment" DeleteMethod="DeleteMethodHandler" InsertMethod="InsertMethodHandler" SelectMethod="SelectMethodHandler" TypeName="WebApplication1.CustomAppointmentDataSource" UpdateMethod="UpdateMethodHandler" OnObjectCreated="ObjectDataSourceAppointment_ObjectCreated"></asp:ObjectDataSource>
		</div>
	</form>
</body>
</html>