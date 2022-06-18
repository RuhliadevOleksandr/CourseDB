<%@ Page Title="Замовлення" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="Курсова_робота.Customer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <br />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="CustomerID" DataSourceID="Clients" AllowSorting="True">
        <Columns>
            <asp:CommandField ShowSelectButton="True" SelectText="Обрати покупця"></asp:CommandField>
            <asp:BoundField DataField="Fullname" HeaderText="ПІБ" SortExpression="Fullname"></asp:BoundField>
        </Columns>
    </asp:GridView>

    <br />

    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="175px" AutoGenerateRows="False" DataSourceID="SelectedClient">
        <Fields>
            <asp:BoundField DataField="CustomerID" HeaderText="Первинний ключ" SortExpression="CustomerID" InsertVisible="False" ReadOnly="True"></asp:BoundField>
            <asp:BoundField DataField="PhoneNumber" HeaderText="Номер телефону" SortExpression="PhoneNumber"></asp:BoundField>
            <asp:BoundField DataField="Fullname" HeaderText="ПІБ" SortExpression="Fullname"></asp:BoundField>
            <asp:CommandField ShowEditButton="True" EditText="Редагувати покупця"></asp:CommandField>
            <asp:CommandField ShowDeleteButton="True" DeleteText="Видалити покупця"></asp:CommandField>
            <asp:CommandField ShowInsertButton="True" NewText="Додати покупця"></asp:CommandField>
        </Fields>
    </asp:DetailsView>

    <br />

    <asp:DetailsView ID="DetailsView2" runat="server" Height="50px" AutoGenerateRows="False" DataKeyNames="LayoutID" DataSourceID="ClientAdvertisements" AllowPaging="True">
        <Fields>
            <asp:BoundField DataField="Theme" HeaderText="Тема" SortExpression="Theme"></asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Опис" SortExpression="Description"></asp:BoundField>
            <asp:BoundField DataField="DateOfRelease" HeaderText="Дата виготовлення" SortExpression="DateOfRelease"></asp:BoundField>
            <asp:BoundField DataField="Reference" HeaderText="Посилання" SortExpression="Reference"></asp:BoundField>
            <asp:CommandField ShowEditButton="True" EditText="Редагувати рекламу"></asp:CommandField>
            <asp:CommandField ShowDeleteButton="True" DeleteText="Видалити рекламу"></asp:CommandField>
            <asp:CommandField ShowInsertButton="True" NewText="Додати рекламу"></asp:CommandField>
        </Fields>
    </asp:DetailsView>

    <br />

    <asp:DetailsView ID="DetailsView3" runat="server" Height="50px" AutoGenerateRows="False" DataSourceID="AdLayoutPlacements" AllowPaging="True">
        <Fields>
            <asp:BoundField DataField="PageNumber" HeaderText="Номер сторінки" SortExpression="PageNumber"></asp:BoundField>
            <asp:BoundField DataField="Cost" HeaderText="Ціна" SortExpression="Cost"></asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Назва" SortExpression="Name"></asp:BoundField>
            <asp:BoundField DataField="Type" HeaderText="Тип" SortExpression="Type"></asp:BoundField>
            <asp:CommandField ShowEditButton="True" EditText="Редагувати розміщення реклами"></asp:CommandField>
            <asp:CommandField ShowDeleteButton="True" DeleteText="Видалити розміщення реклами"></asp:CommandField>
            <asp:CommandField ShowInsertButton="True" NewText="Додати розміщення реклами"></asp:CommandField>
        </Fields>
    </asp:DetailsView>

    <asp:SqlDataSource runat="server" ID="ClientAdvertisements" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>' SelectCommand="SELECT * FROM [Advertisment] JOIN [Layout] ON [Advertisment].[AdvertismentId] = [Layout].[AdvertismentId] WHERE ([CustomerID] = @CustomerID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="CustomerID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Clients" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>' SelectCommand="SELECT [CustomerID], [Fullname] FROM [Customer]"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SelectedClient" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>' SelectCommand="SELECT * FROM [Customer] WHERE ([CustomerID] = @CustomerID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="CustomerID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="AdLayoutPlacements" ConnectionString='<%$ ConnectionStrings:MagazineAdConnection %>' SelectCommand="SELECT * FROM [LayoutPlacement] JOIN [Publication] ON [LayoutPlacement].[PublicationID] = [Publication].[PublicationID] WHERE ([LayoutId] = @LayoutID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DetailsView2" PropertyName="SelectedValue" Name="LayoutID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
