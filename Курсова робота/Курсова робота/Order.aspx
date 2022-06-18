<%@ Page Title="Замовлення" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="Курсова_робота.Customer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        function isDelete(name) {
            return confirm("Ви впевнені, що хочете видалити " + name +" ?");
        }
    </script>

    <br />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="CustomerID" DataSourceID="Clients" AllowSorting="True">
        <Columns>
            <asp:CommandField ShowSelectButton="True" SelectText="Обрати покупця"></asp:CommandField>
            <asp:BoundField DataField="Fullname" HeaderText="ПІБ" SortExpression="Fullname"></asp:BoundField>
            <asp:TemplateField >
			<ItemTemplate>
				    <asp:LinkButton ID="DeleteClient" runat="server" CommandName="Delete"
				        OnClientClick="return isDelete('клієнта');">Видалити покупця
				    </asp:LinkButton>
			    </ItemTemplate>
		    </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <br />

    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="175px" AutoGenerateRows="False" DataSourceID="SelectedClient">
        <Fields>
            <asp:BoundField DataField="CustomerID" HeaderText="Первинний ключ" InsertVisible="False" ReadOnly="True"></asp:BoundField>
            <asp:BoundField DataField="PhoneNumber" HeaderText="Номер телефону" ></asp:BoundField>
            <asp:BoundField DataField="Fullname" HeaderText="ПІБ" SortExpression="Fullname"></asp:BoundField>
            <asp:CommandField ShowEditButton="True" EditText="Редагувати покупця"></asp:CommandField>
            <asp:CommandField ShowInsertButton="True" NewText="Додати покупця"></asp:CommandField>
        </Fields>
    </asp:DetailsView>

    <br />

    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="AdvertismentId" DataSourceID="ClientAdvertisements" AllowSorting="True">
        <Columns>
            <asp:CommandField ShowSelectButton="True" SelectText="Обрати рекламу"></asp:CommandField>
            <asp:BoundField DataField="Theme" HeaderText="Тема" SortExpression="Theme"></asp:BoundField>
            <asp:TemplateField >
			<ItemTemplate>
				    <asp:LinkButton ID="DeleteAd" runat="server" CommandName="Delete"
				        OnClientClick="return isDelete('рекламу');">Видалити рекламу
				    </asp:LinkButton>
			    </ItemTemplate>
		    </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <br />

    <asp:DetailsView ID="DetailsView2" runat="server" Height="50px" Width="175px" AutoGenerateRows="False"  DataSourceID="SelectedAd">
        <Fields>
            <asp:BoundField DataField="AdvertismentId" HeaderText="Первинний ключ" InsertVisible="False" ReadOnly="True"></asp:BoundField>
            <asp:BoundField DataField="Theme" HeaderText="Тема" SortExpression="Theme"></asp:BoundField>
            <asp:BoundField DataField="DateOfRelease" HeaderText="Дата виготовлення"></asp:BoundField>
            <asp:BoundField DataField="CustomerID" HeaderText="Зовнішний ключ(ключ клієнта)"></asp:BoundField>
            <asp:CommandField ShowEditButton="True" EditText="Редагувати рекламу"></asp:CommandField>
            <asp:CommandField ShowInsertButton="True" NewText="Додати рекламу"></asp:CommandField>
        </Fields>
    </asp:DetailsView>
    
    <br />

    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="LayoutID" DataSourceID="AdLayouts">
        <Columns>
            <asp:BoundField DataField="Reference" HeaderText="Посилання"></asp:BoundField>
            <asp:TemplateField >
			    <ItemTemplate>
				    <asp:LinkButton ID="DeleteLayout" runat="server" CommandName="Delete"
				        OnClientClick="return isDelete('макет');">Видалити макет
				    </asp:LinkButton>
			    </ItemTemplate>
		    </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <br />

    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="LayoutPlacementID" DataSourceID="AdLayoutPlacements">
        <Columns>
            <asp:BoundField DataField="PageNumber" HeaderText="Номер сторінки" SortExpression="PageNumber"></asp:BoundField>
            <asp:BoundField DataField="Cost" HeaderText="Ціна" SortExpression="Cost"></asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Назва" SortExpression="Name"></asp:BoundField>
            <asp:BoundField DataField="Type" HeaderText="Тип" SortExpression="Type"></asp:BoundField>
            <asp:TemplateField >
			    <ItemTemplate>
				    <asp:LinkButton ID="DeleteLayout" runat="server" CommandName="Delete"
				        OnClientClick="return isDelete('розміщення макету');">Видалити розміщення макету
				    </asp:LinkButton>
			    </ItemTemplate>
		    </asp:TemplateField>
        </Columns>
    </asp:GridView>
    

    <asp:SqlDataSource runat="server" ID="Clients" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>' 
        SelectCommand="SELECT [CustomerID], [Fullname] FROM [Customer]"
        DeleteCommand="DELETE FROM Customer WHERE ([CustomerID] = @CustomerID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="CustomerId" PropertyName="SelectedDataKey" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="ClientAdvertisements" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>'
        SelectCommand="SELECT [AdvertismentId], [Theme] FROM [Advertisment] WHERE ([CustomerID] = @CustomerID)"
        DeleteCommand="DELETE FROM Advertisment WHERE ([AdvertismentId] = @AdvertismentId)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="CustomerID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView2" Name="AdvertismentId" PropertyName="SelectedDataKey" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SelectedClient" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>'
        SelectCommand="SELECT * FROM [Customer] WHERE ([CustomerID] = @CustomerID)"
        InsertCommand="INSERT INTO Customer(Fullname, PhoneNumber) VALUES (@Fullname, @PhoneNumber)"
        UpdateCommand="UPDATE Customer SET Fullname = @Fullname, PhoneNumber = @PhoneNumber WHERE ([CustomerID] = @CustomerId)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="CustomerID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="Fullname" Type="String" />
            <asp:Parameter Name="PhoneNumber" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Fullname" Type="String" />
            <asp:Parameter Name="PhoneNumber" Type="String" />
            <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="CustomerID" Type="Int32"></asp:ControlParameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SelectedAd" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>'
        SelectCommand="SELECT * FROM [Advertisment] WHERE ([AdvertismentId] = @AdvertismentId)"
        InsertCommand="INSERT INTO Advertisment(Theme, DateOfRelease, CustomerID) VALUES (@Theme, @DateOfRelease, @CustomerID)"
        UpdateCommand="UPDATE Advertisment SET Theme = @Theme, DateOfRelease = @DateOfRelease, CustomerID = @CustomerId WHERE ([AdvertismentId] = @AdvertismentId)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView2" PropertyName="SelectedValue" Name="AdvertismentId" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="Theme"></asp:Parameter>
            <asp:Parameter Name="DateOfRelease"></asp:Parameter>
            <asp:Parameter Name="CustomerID"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Theme" />
            <asp:Parameter Name="DateOfRelease" />
            <asp:Parameter Name="CustomerId" />
            <asp:ControlParameter ControlID="GridView2" PropertyName="SelectedValue" Name="AdvertismentId" Type="Int32"></asp:ControlParameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="AdLayouts" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>'
        SelectCommand="SELECT LayoutID, Reference FROM Layout WHERE Reference IS NOT NULL AND ([AdvertismentId] = @AdvertismentId)"
        DeleteCommand="DELETE FROM Layout WHERE ([LayoutID] = @LayoutID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView2" PropertyName="SelectedValue" Name="AdvertismentId" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView3" Name="LayoutID" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="AdLayoutPlacements" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>'
        SelectCommand="SELECT * FROM [LayoutPlacement] JOIN [Publication] ON [LayoutPlacement].[PublicationID] = [Publication].[PublicationID] 
                       WHERE [LayoutId] = (SELECT TOP(1) LayoutID FROM Layout WHERE AdvertismentID = @AdvertismentId)"
        DeleteCommand="DELETE FROM [LayoutPlacement]  WHERE ([LayoutPlacementID] = @LayoutPlacementID); 
                       UPDATE Publication SET LayoutPlacementID = NULL WHERE ([LayoutPlacementID] = @LayoutPlacementID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView2" PropertyName="SelectedValue" Name="AdvertismentId" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView4" Name="LayoutPlacementID" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>
