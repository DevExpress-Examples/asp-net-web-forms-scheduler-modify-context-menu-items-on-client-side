Imports System
Imports System.ComponentModel
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web.ASPxScheduler

Namespace WebApplication1

    Public Partial Class [Default]
        Inherits Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
            If Not IsPostBack Then
            End If
        End Sub

        Protected Sub ObjectDataSourceResources_ObjectCreated(ByVal sender As Object, ByVal e As ObjectDataSourceEventArgs)
            If Session("CustomResourceDataSource") Is Nothing Then
                Session("CustomResourceDataSource") = New CustomResourceDataSource(GetCustomResources())
            End If

            e.ObjectInstance = Session("CustomResourceDataSource")
        End Sub

        Private Function GetCustomResources() As BindingList(Of CustomResource)
            Dim resources As BindingList(Of CustomResource) = New BindingList(Of CustomResource)()
            resources.Add(CreateCustomResource(1, "Max Fowler"))
            resources.Add(CreateCustomResource(2, "Nancy Drewmore"))
            resources.Add(CreateCustomResource(3, "Pak Jang"))
            Return resources
        End Function

        Private Function CreateCustomResource(ByVal res_id As Integer, ByVal caption As String) As CustomResource
            Dim cr As CustomResource = New CustomResource()
            cr.ResID = res_id
            cr.Name = caption
            Return cr
        End Function

        Public RandomInstance As Random = New Random()

        Private Function CreateCustomAppointment(ByVal subject As String, ByVal resourceId As Object, ByVal status As Integer, ByVal label As Integer) As CustomAppointment
            Dim apt As CustomAppointment = New CustomAppointment()
            apt.Subject = subject
            apt.OwnerId = resourceId
            Dim rnd As Random = RandomInstance
            Dim rangeInMinutes As Integer = 60 * 24
            apt.StartTime = Date.Today + TimeSpan.FromMinutes(rnd.Next(0, rangeInMinutes))
            apt.EndTime = apt.StartTime + TimeSpan.FromMinutes(rnd.Next(0, rangeInMinutes \ 4))
            apt.Status = status
            apt.Label = label
            Return apt
        End Function

        Protected Sub ObjectDataSourceAppointment_ObjectCreated(ByVal sender As Object, ByVal e As ObjectDataSourceEventArgs)
            If Session("CustomAppointmentDataSource") Is Nothing Then
                Session("CustomAppointmentDataSource") = New CustomAppointmentDataSource(GetCustomAppointments())
            End If

            e.ObjectInstance = Session("CustomAppointmentDataSource")
        End Sub

        Private Function GetCustomAppointments() As BindingList(Of CustomAppointment)
            Dim appointments As BindingList(Of CustomAppointment) = New BindingList(Of CustomAppointment)()
            Dim resources As CustomResourceDataSource = TryCast(Session("CustomResourceDataSource"), CustomResourceDataSource)
            If resources IsNot Nothing Then
                For Each item As CustomResource In resources.Resources
                    Dim subjPrefix As String = item.Name & "'s "
                    appointments.Add(CreateCustomAppointment(subjPrefix & "meeting", item.ResID, 2, 5))
                    appointments.Add(CreateCustomAppointment(subjPrefix & "travel", item.ResID, 3, 6))
                    appointments.Add(CreateCustomAppointment(subjPrefix & "phone call", item.ResID, 0, 10))
                Next
            End If

            Return appointments
        End Function

        Protected Sub ASPxScheduler1_PopupMenuShowing(ByVal sender As Object, ByVal e As PopupMenuShowingEventArgs)
            e.Menu.ClientSideEvents.PopUp = "OnClientPopupMenuShowing"
        End Sub

        Protected Sub ASPxScheduler1_InitClientAppointment(ByVal sender As Object, ByVal args As InitClientAppointmentEventArgs)
            args.Properties.Add(ClientSideAppointmentFieldNames.Subject, args.Appointment.Subject)
        End Sub
    End Class
End Namespace
