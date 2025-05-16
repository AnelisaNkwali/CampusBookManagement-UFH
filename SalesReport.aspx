<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/CampusBooks.Master" AutoEventWireup="true" CodeBehind="SalesReport.aspx.cs" Inherits="CampusBooks_AnelisaNkwali_202249214_.WebForm.SalesReport" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container mt-4">
        <h2 class="mb-4">Sales Report</h2>

        <!-- Filter Controls -->
        <div class="row mb-3">
            <div class="col-md-4">
                <label>Start Date:</label>
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date" />
            </div>
            <div class="col-md-4">
                <label>End Date:</label>
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date" />
            </div>
            <div class="col-md-4">
                <label>Category:</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AutoPostBack="true" />
            </div>
        </div>

        <!-- Filter Button -->
        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-primary mb-3" OnClick="btnFilter_Click" />

        <asp:GridView ID="GridViewSales" runat="server" CssClass="table table-bordered table-striped" 
              AutoGenerateColumns="False" DataKeyNames="SaleID" DataSourceID="SqlDataSourceSales">
    <Columns>
        <asp:BoundField DataField="SaleID" HeaderText="Sale ID" ReadOnly="True" />
        <asp:BoundField DataField="Title" HeaderText="Book Title" />
        <asp:BoundField DataField="QuantitySold" HeaderText="Quantity Sold" />
        <asp:BoundField DataField="SaleDate" HeaderText="Sale Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="Total" HeaderText="Total (R)" DataFormatString="{0:C}" />
    </Columns>
</asp:GridView>

         <asp:SqlDataSource ID="salesdatasource" runat="server" ConnectionString="<%$ ConnectionStrings:CampusBooksDBConnectionString2 %>" SelectCommand="SELECT * FROM [Sales]"></asp:SqlDataSource>

        <!-- SqlDataSource for Sales Data -->
        <asp:SqlDataSource ID="SqlDataSourceSales" runat="server" 
                          ConnectionString="Data Source=LISA\SQLEXPRESS;Initial Catalog=CampusBooksDB;Integrated Security=True" 
                          SelectCommand="SELECT s.SaleID, b.Title, s.QuantitySold, s.SaleDate, (s.QuantitySold * b.Price) AS Total 
                                         FROM Sales s INNER JOIN Books b ON s.BookID = b.BookID WHERE 1=1">
            <SelectParameters>
                <asp:Parameter Name="StartDate" Type="DateTime" />
                <asp:Parameter Name="EndDate" Type="DateTime" />
                <asp:Parameter Name="Category" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

         <asp:ScriptManager ID="ScriptManager1" runat="server">
         </asp:ScriptManager>
         <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" Width="1159px">
             <LocalReport ReportPath="salesDataSet.rdlc">
                 <DataSources>
                     <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                 </DataSources>
             </LocalReport>
         </rsweb:ReportViewer>
         <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetData" TypeName="CampusBooks_AnelisaNkwali(202249214).CampusBooksDBDataSetTableAdapters.vw_SalesSummaryByCategoryTableAdapter"></asp:ObjectDataSource>
         <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="CampusBooks_AnelisaNkwali_202249214_.CampusBooksDBDataSetTableAdapters.vw_SalesSummaryByCategoryTableAdapter"></asp:ObjectDataSource>
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CampusBooksDBConnectionString %>" SelectCommand="SELECT 
    Books.Category,
    SUM(Sales.QuantitySold) AS TotalBooksSold,
    SUM(Sales.QuantitySold * Books.Price) AS TotalRevenue
FROM 
    Books
INNER JOIN 
    Sales ON Books.BookID = Sales.BookID
GROUP BY 
    Books.Category;
"></asp:SqlDataSource>

    </div>
</asp:Content>
