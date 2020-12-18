<%@ page import="java.util.Locale" %>
<%@ page import="controller.Employee" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<div id="home">
    <h2 style="color: #000000">Leave management</h2>
    <%
        out.print("<h3>Hello " + Controller.selectWhereEmployee(Integer.parseInt(session.getAttribute("id")
            .toString())).getFirstName() + " " + Controller
            .selectWhereEmployee(Integer.parseInt(session.getAttribute("id")
            .toString())).getLastName().charAt(0) + ".</h3>");
        Employee employee = Controller.selectWhereEmployee(Integer
            .parseInt(session.getAttribute("id").toString()));
        DecimalFormat decimalFormat = new DecimalFormat("#.#");
    %>
    <div class="table-wrapper">
        <table class="fl-table">
            <thead>
            <tr>
                <th>Remaining leave days</th>
                <th>Used leave days</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    <%
                        out.print(decimalFormat.format(employee
                            .getRemaining()));
                    %>
                </td>
                <td>
                    <%
                        out.print(String.valueOf(employee.getUsed())
                        .endsWith(".0") ? String.valueOf(employee.getUsed())
                        .split("[.]")[0] : decimalFormat.format(employee
                            .getUsed()));
                    %>
                </td>
            </tr>
            <tr>
                <td colspan="2" id="legal">An employee acquires 2.5 working days of paid leave per month of actual work with the same employer (Article L3141-3 of the French Labor Code).<br>One month corresponds to 4 weeks, or 24 working days.</td>
            </tr>
            </tbody>
        </table>
    </div>
    <h4>Your leaves</h4>
    <div class="table-wrapper">
        <table class="fl-table">
            <thead>
            <tr>
                <th>Start date of leave</th>
                <th>End date of leave</th>
                <th>Full day(s)</th>
                <th>Reason</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <%
                if (request.getParameter("action") != null && session
                        .getAttribute("id") != null) {
                    switch (request.getParameter("action")) {
                        case "delete":
                            Controller.deleteLeaves(Integer.parseInt(request
                                    .getParameter("id")));
                            break;
                        case "add":
                            break;
                        default:
                            break;
                    }
                }
                String leaves = "";
                for (Leaves aLeaves : Controller.selectWhereLeaves(Integer
                        .parseInt(session.getAttribute("id").toString()))) {
                    leaves += "<tr>";
                    String[] start = aLeaves.getStart().split("-");
                    String[] end = aLeaves.getEnd().split("-");
//                    if (aLeaves.getFullDay().toString().equals("Yes")) {
                        leaves += "<td>" + start[2].substring(0, 2) + "/" +
                            start[1] + "/" + start[0] + "</td>";
                        leaves += "<td>" + (Integer.parseInt(end[2].substring(0,
                            2)) - 1) + "/" + end[1] + "/" + end[0] + "</td>";
//                    } else {
//                        leaves += "<td>" + start[2].substring(0, 2) + "/" +
//                            start[1] + "/" + start[0] + " " + start[2]
//                            .substring(3, start[2].length() - 2) + "</td>";
//                        leaves += "<td>" + (Integer.parseInt(end[2].substring(0,
//                            2)) - 1) + "/" + end[1] + "/" + end[0] + " " +
//                            end[2].substring(3, end[2].length() - 2) + "</td>";
//                    }
                    leaves += "<td>" + aLeaves.getFullDay() + "</td>";
                    leaves += "<td>" + aLeaves.getReason() + "</td>";
                    SimpleDateFormat simpleDateFormat = new
                        SimpleDateFormat("yyyy-MM-dd");
                    try {
                        if (simpleDateFormat.parse(aLeaves.getStart()
                            .split(" ")[0]).before(simpleDateFormat
                            .parse(java.time.LocalDate.now().toString()))) {
                            leaves += "<td><img src='img/grayscale.webp' styl" +
                                "e='height: 15px'></td>";
                        } else {
                            leaves += "<td><a href='index.jsp?action=delete&i" +
                                "d=" + aLeaves.getId() + "'><img src='img/can" +
                                "cel-146131_1280.webp' style='height: 15px'><" +
                                "/a></td>";
                        }
                    } catch (java.text.ParseException e) {
                        System.out.println("");
                    }
                    leaves += "</tr>";
                }
                if (request.getParameter("action") != null && request
                    .getParameter("action").toString().equals("add") && session
                    .getAttribute("id") != null) {
                    leaves += "<tr>";
                    leaves += "<td>";
                    leaves += "<input name='startDate' placeholder='YYYY-MM-D" +
                            "D' type='text'>";
                    leaves += "</td>";
                    leaves += "<td>";
                    leaves += "<input name='endDate' placeholder='YYYY-MM-DD'" +
                            " type='text'>";
                    leaves += "</td>";
                    leaves += "<td>";
                    leaves += "<select name='fullDay'>";
                    leaves += "<option value='Yes'>Yes</option>";
                    leaves += "<option value='Morning'>Morning</option>";
                    leaves += "<option value='Afternoon'>Afternoon</option>";
                    leaves += "</select>";
                    leaves += "</td>";
                    leaves += "<td>";
                    leaves += "<input name='reason' placeholder='Optional' ty" +
                        "pe='text'>";
                    leaves += "</td>";
                    leaves += "</tr>";
                } else {
                    leaves += "<tr><td colspan='5'><a href='index.jsp?action=" +
                        "add'><img src='img/plus-124-459368.webp' style='heig" +
                        "ht: 15px'></a></td></tr>";
                }
                out.print(leaves);
            %>
            </tbody>
        </table>
    </div>
</div>
