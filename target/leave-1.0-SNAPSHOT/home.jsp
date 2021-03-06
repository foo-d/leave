<%@ page import="java.util.Locale" %>
<%@ page import="controller.Employee" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.time.Duration" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.time.LocalDateTime" %>
<div id="home">
    <h2 style="color: #000000">Leave management</h2>
    <%
        if (request.getParameter("action") != null && session
            .getAttribute("id") != null) {
            if (request.getParameter("action").toString()
                .equals("delete")) {
                Controller.deleteLeaves(Integer.parseInt(request
                    .getParameter("id")));
            }
        }
        if (request.getParameter("submit") != null && session
            .getAttribute("id") != null) {
            String start = request.getParameter("start").toString();
            String end = request.getParameter("end").toString();
            SimpleDateFormat simpleDateFormat =
                new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat simpleDateFormat0 =
                    new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                Calendar calendar = Calendar.getInstance();
                switch (request.getParameter("fullDay").toString()) {
                    case "Yes":
                        start += " 00:00:00";
                        try {
                            calendar.setTime(simpleDateFormat.parse(end));
                            calendar.add(Calendar.DATE, 1);
                            end = simpleDateFormat.format(calendar.getTime()) +
                                " 00:00:00";
                        } catch (java.text.ParseException e) {
                            System.out.println("");
                        };
                        break;
                    case "Morning":
                        start += " 00:00:00";
                        try {
                            calendar.setTime(simpleDateFormat.parse(end));
                            calendar.add(Calendar.DATE, 0);
                            end = simpleDateFormat.format(calendar.getTime()) +
                                " 12:00:00";
                        } catch (java.text.ParseException e) {
                            System.out.println("");
                        }
                        break;
                    case "Afternoon":
                        start += " 12:00:00";
                        try {
                            calendar.setTime(simpleDateFormat.parse(end));
                            calendar.add(Calendar.DATE, 1);
                            end = simpleDateFormat.format(calendar.getTime()) +
                                " 00:00:00";
                        } catch (java.text.ParseException e) {
                            System.out.println("");
                        }
                        break;
                    default:
                        break;
                }
                if (simpleDateFormat0.parse(start).after(simpleDateFormat0.parse(simpleDateFormat0.format(new Date())))) {
                    if (simpleDateFormat0.parse(start).before(simpleDateFormat0
                            .parse(end))) {
                        if (((simpleDateFormat0.parse(end).getTime() - simpleDateFormat0.parse(start).getTime()) / (1000 * 60 * 60)) / 24 <= 3.5) {
                            Controller.insertLeaves(new Leaves(
                                start,
                                end,
                                request.getParameter("fullDay").toString(),
                                request.getParameter("reason").toString(),
                                Integer.parseInt(session.getAttribute("id").toString())
                            ));
                        } else {
                            out.print("<div style='background-color: #ff8080; padding: 15px; width: 75%'>Error in adding leave, check that you have a sufficient number of remaining leaves.</div>");
                        }
                    } else {
                        out.print("<div style='background-color: #ff8080; padding: 15px; width: 75%'>Error in adding the leave, verify that the end date of the leave is greater than the start date.</div>");
                    }
                } else {
                    out.print("<div style='background-color: #ff8080; padding: 15px; width: 75%'>Error in the addition of the leave, check that the start date of the leave is not in the past.</div>");
                }
            } catch (java.text.ParseException e) {
                out.print("<div style='background-color: #ff8080; padding: 15" +
                    "px; width: 75%'>Error in adding the leave, the dates ent" +
                    "ered are invalid</div>");
                System.out.println("");
            }
        }
        out.print("<h3>Hello " + Controller.selectWhereEmployee(Integer
            .parseInt(session.getAttribute("id").toString())).getFirstName() +
            " " + Controller.selectWhereEmployee(Integer.parseInt(session
            .getAttribute("id").toString())).getLastName().charAt(0) +
            ".</h3>");
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
                String leaves = "";
                for (Leaves aLeaves : Controller.selectWhereLeaves(Integer
                        .parseInt(session.getAttribute("id").toString()))) {
                    leaves += "<tr>";
                    String[] start = aLeaves.getStart().split("-");
                    String[] end = aLeaves.getEnd().split("-");
                    leaves += "<td>" + start[2].substring(0, 2) + "/" +
                        start[1] + "/" + start[0] + "</td>";

                    Calendar calendar = Calendar.getInstance();
                    SimpleDateFormat simpleDateFormat =
                        new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        calendar.setTime(simpleDateFormat.parse(aLeaves
                            .getEnd()));
                        if (!aLeaves.getFullDay().equals("Morning")) {
                            calendar.add(Calendar.DATE, -1);
                        }
                        end = simpleDateFormat.format(calendar.getTime())
                            .split("-");
                    } catch (java.text.ParseException e) {
                        System.out.println("");
                    }
                    leaves += "<td>" + (Integer.parseInt(end[2].substring(0,
                        2))) + "/" + end[1] + "/" + end[0] + "</td>";
                    leaves += "<td>" + aLeaves.getFullDay() + "</td>";
                    leaves += "<td>" + aLeaves.getReason() + "</td>";
                    try {
                        if (simpleDateFormat.parse(aLeaves.getStart()
                            .split(" ")[0]).before(simpleDateFormat
                            .parse(java.time.LocalDate.now().toString()))) {
                            leaves += "<td><img src='img/grayscale.webp' styl" +
                                "e='height: 16px'></td>";
                        } else {
                            leaves += "<td><a href='index.jsp?action=delete&i" +
                                "d=" + aLeaves.getId() + "'><img src='img/can" +
                                "cel-146131_1280.webp' style='height: 16px'><" +
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
                    leaves += "<form action='' method='post'>";
                    leaves += "<td>";
                    leaves += "<input name='start' placeholder='YYYY-MM-DD' t" +
                        "ype='text'>";
                    leaves += "</td>";
                    leaves += "<td>";
                    leaves += "<input name='end' placeholder='YYYY-MM-DD' typ" +
                        "e='text'>";
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
                    leaves += "<td>";
                    leaves += "<a href='index.jsp'>";
                    leaves += "<img src='img/cancel-146131_1280.webp' style='" +
                        "height: 16px'>";
                    leaves += "</a>";
                    leaves += "</td>";
                    leaves += "<tr>";
                    leaves += "<td colspan=5>";
                    leaves += "<input name='submit' type='submit' value='Subm" +
                        "it'>";
                    leaves += "</td>";
                    leaves += "</tr>";
                    leaves += "</form>";
                    leaves += "</tr>";
                } else {
                    leaves += "<tr><td colspan='5'><a href='index.jsp?action=" +
                        "add'><img src='img/plus-124-459368.webp' style='heig" +
                        "ht: 16px'></a></td></tr>";
                }
                out.print(leaves);
            %>
            </tbody>
        </table>
    </div>
    <form action="" method="post">
        <button name="logout" type="submit">
            <img alt="" src="img/1024px-OOjs_UI_icon_logOut-ltr.svg.png" style="height: 16px">
        </button>
    </form>
</div>
