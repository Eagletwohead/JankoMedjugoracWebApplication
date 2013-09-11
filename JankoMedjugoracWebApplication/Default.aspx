<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="JankoMedjugoracWebApplication._Default" %>

<asp:Content runat="server" ID="JavaScriptContent" ContentPlaceHolderID="JavaScriptContent">

    <script type="text/javascript">
        function cleanInputs() {
            $('input:text').val("");
        }
    </script>
</asp:Content>
<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1>Numerspiel.</h1>
                <h2>Preview applicaton.</h2>
            </hgroup>
            <p>
                Preview web applicaton for applying for job as ASP.NET developer. Made by Janko Medjugorac
            </p>
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h3>Insert number range:</h3>
    <table>
        <tr>
            <td>
                <asp:Localize ID="lclStartNumber" runat="server" Text="Start number"></asp:Localize></td>
            <td>
                <asp:TextBox ID="txtStartNumber" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvtxtStartNumber" runat="server" ControlToValidate="txtStartNumber"
                    ErrorMessage="Please enter starting number for interval." Display="Dynamic" ValidationGroup="CalculateValidation"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cmvtxtStartNumber" runat="server" Type="Integer" ControlToValidate="txtStartNumber"
                    ErrorMessage="Start needs to be whole number." Display="Dynamic" ValidationGroup="CalculateValidation" Operator="DataTypeCheck"></asp:CompareValidator>

            </td>

        </tr>
        <tr>
            <td>
                <asp:Localize ID="lclEndNumber" runat="server" Text="End number"></asp:Localize></td>
            <td>
                <asp:TextBox ID="txtEndNumber" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEndNumer" runat="server" ControlToValidate="txtEndNumber"
                    ErrorMessage="Please enter ending number for interval." Display="Dynamic" ValidationGroup="CalculateValidation"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cmvtxtEndNumber" runat="server" Type="Integer" ControlToValidate="txtEndNumber"
                    ErrorMessage="End needs to be whole number." Display="Dynamic" ValidationGroup="CalculateValidation" Operator="DataTypeCheck"></asp:CompareValidator>
                <asp:CompareValidator ID="cmvRange" runat="server" ControlToValidate="txtEndNumber"
                    ErrorMessage="End needs to be equal or greater then Start." Display="Dynamic" ValidationGroup="CalculateValidation" ControlToCompare="txtStartNumber" Operator="GreaterThanEqual"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="btnCalculate" runat="server" Text="Calculate" ValidationGroup="CalculateValidation"
                    CssClass="preview_button" OnClick="btnCalculate_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClientClick="cleanInputs(); return false;" CssClass="preview_button" /></td>
        </tr>
    </table>

    <asp:UpdatePanel runat="server" ID="upnlResults">
        <ContentTemplate>
            <asp:ListView ID="lvwResults" runat="server" GroupItemCount="10">
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server" id="groupPlaceholder"></tr>
                    </table>
                </LayoutTemplate>
                <GroupTemplate>
                    <tr runat="server" id="tableRow">
                        <td runat="server" id="itemPlaceholder" />
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                    <td runat="server">
                        <asp:Label ID="lblResult" runat="server"
                            Text='<%#Eval("Text") %>' />
                    </td>
                </ItemTemplate>
            </asp:ListView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
