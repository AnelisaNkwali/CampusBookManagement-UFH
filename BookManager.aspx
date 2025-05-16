<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/CampusBooks.Master" AutoEventWireup="true" CodeBehind="BookManager.aspx.cs" Inherits="CampusBooks_AnelisaNkwali_202249214_.WebForm.BookManager" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <h2 class="text-center mb-4">Books Management</h2>

        <!-- DetailsView for Adding New Books -->
<div class="card mb-4">
    <div class="card-header bg-primary text-white">
        Add New Book
    </div>
    <div class="card-body">
        <asp:DetailsView ID="DetailsViewAddBook" runat="server" 
            DataSourceID="SqlDataSourceBooks" 
            DefaultMode="Insert" 
            AutoGenerateInsertButton="True" 
            AutoGenerateRows="False" 
            CssClass="table table-bordered">
            <Fields>
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="Author" HeaderText="Author" SortExpression="Author" />
                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                
                
                <asp:TemplateField HeaderText="Quantity">
                    <InsertItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" 
                                     Text='<%# Bind("QuantityAvailable") %>' 
                                     TextMode="Number" CssClass="form-control" />
                    </InsertItemTemplate>
                </asp:TemplateField>

                
                <asp:TemplateField HeaderText="Price (R)">
                    <InsertItemTemplate>
                        <asp:TextBox ID="txtPrice" runat="server" 
                                     Text='<%# Bind("Price") %>' 
                                     TextMode="Number" CssClass="form-control" />
                    </InsertItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
    </div>
</div>

        
        <div class="card">
            <div class="card-header bg-success text-white">
                Book List
            </div>
            <div class="card-body">
                <asp:GridView ID="GridViewBooks" runat="server" 
                    DataSourceID="SqlDataSourceBooks" 
                    AutoGenerateColumns="False" 
                    DataKeyNames="BookID" 
                    CssClass="table table-striped table-bordered" 
                    AllowPaging="True" 
                    AllowSorting="True">
                    <Columns>
                        <asp:BoundField DataField="BookID" HeaderText="ID" ReadOnly="True" SortExpression="BookID" />
                        <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                        <asp:BoundField DataField="Author" HeaderText="Author" SortExpression="Author" />
                        <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                        <asp:BoundField DataField="QuantityAvailable" HeaderText="Quantity" SortExpression="QuantityAvailable" />
                        <asp:BoundField DataField="Price" HeaderText="Price (R)" SortExpression="Price" DataFormatString="{0:C}" />
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceBooks" runat="server"
    ConnectionString="Data Source=LISA\SQLEXPRESS;Initial Catalog=CampusBooksDB;Integrated Security=True"
    SelectCommand="SELECT * FROM Books"
    InsertCommand="INSERT INTO Books (Title, Author, Category, QuantityAvailable, Price) VALUES (@Title, @Author, @Category, @QuantityAvailable, @Price)"
    UpdateCommand="UPDATE Books SET Title=@Title, Author=@Author, Category=@Category, QuantityAvailable=@QuantityAvailable, Price=@Price WHERE BookID=@BookID"
    DeleteCommand="DELETE FROM Books WHERE BookID=@BookID">
    <InsertParameters>
        <asp:Parameter Name="Title" Type="String" />
        <asp:Parameter Name="Author" Type="String" />
        <asp:Parameter Name="Category" Type="String" />
        <asp:Parameter Name="QuantityAvailable" Type="Int32" />
        <asp:Parameter Name="Price" Type="Decimal" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Title" Type="String" />
        <asp:Parameter Name="Author" Type="String" />
        <asp:Parameter Name="Category" Type="String" />
        <asp:Parameter Name="QuantityAvailable" Type="Int32" />
        <asp:Parameter Name="Price" Type="Decimal" />
        <asp:Parameter Name="BookID" Type="Int32" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="BookID" Type="Int32" />
    </DeleteParameters>
</asp:SqlDataSource>
</asp:Content>
