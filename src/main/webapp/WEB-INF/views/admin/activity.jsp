<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
<c:url var="activityUrl" value="/admin/activity"/>

<c:set var="currentPath" value="${pageContext.request.requestURI}" />
<html>
<head>
    <title>Recent Activity</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
        body { font-family: Inter, Arial, sans-serif; background: #f6f7fb; margin:0; }
        .wrap { max-width: 1100px; margin: 28px auto; background: #fff; padding: 22px 24px; border-radius: 14px; box-shadow: 0 8px 30px rgba(0,0,0,.06); }
        h2 { margin: 0 0 18px; color:#1f2937; }
        .filters { display:flex; gap:12px; flex-wrap: wrap; align-items: end; margin-bottom: 14px; }
        .filters label { font-size: 12px; color:#374151; display:block; margin-bottom:6px; }
        .filters input[type="date"], .filters select, .filters input[type="text"] { padding:9px 10px; border:1px solid #d1d5db; border-radius:10px; min-width:160px; }
        .filters .btn { padding:10px 14px; border:none; border-radius:10px; cursor:pointer; }
        .btn-primary { background:#2563eb; color:#fff; }
        .btn-light { background:#f3f4f6; }
        
        .btn {
		    padding: 10px 16px;
		    border: none;
		    border-radius: 10px;
		    cursor: pointer;
		    font-weight: 500;
		    font-size: 14px;
		    text-decoration: none;
		    display: inline-block;
		    transition: all 0.2s ease;
		}
		
		/* Apply button (primary, blue) */
		.btn-apply {
		    background: #2563eb;
		    color: #fff;
		    border: 1px solid #2563eb;
		}
		.btn-apply:hover {
		    background: #1d4ed8;
		}
		
		/* Reset button (soft gray with icon) */
		.btn-reset {
		    background: #f3f4f6;
		    color: #374151;
		    border: 1px solid #d1d5db;
		}
		.btn-reset:hover {
		    background: #e5e7eb;
		    border-color: #9ca3af;
		}
		.btn-reset:before {
		    content: "⟳ ";
		    font-weight: bold;
		}

        .btn-back {
		    background: #10b981; /* emerald green */
		    color: #fff;
		    border: 1px solid #10b981;
		    padding: 10px 16px;
		    border-radius: 10px;
		    cursor: pointer;
		    font-weight: 500;
		    font-size: 14px;
		    text-decoration: none;
		    display: inline-block;
		    transition: all 0.2s ease;
		}
		.btn-back:hover {
		    background: #059669;
		    border-color: #059669;
		}
		.btn-back:before {
		    font-weight: bold;
		}
        
        table { width:100%; border-collapse: collapse; background:#fff; }
        th, td { padding:12px 10px; border-bottom:1px solid #eee; text-align:left; }
        th { background:#f9fafb; color:#374151; font-weight:600; }
        .muted { color:#6b7280; font-size:12px; }
        .badge { display:inline-block; padding:4px 8px; border-radius:999px; font-size:12px; background:#eef2ff; }
        .empty { padding:24px; text-align:center; color:#6b7280; }
        .topbar { display:flex; justify-content: space-between; align-items:center; margin-bottom:10px; }
        .pagination {
		    display: flex;
		    gap: 6px;
		    align-items: center;
		    margin-top: 16px;
		}
		
		.pagination a, 
		.pagination span {
		    padding: 8px 14px;
		    border-radius: 8px;
		    border: 1px solid #d1d5db;
		    text-decoration: none;
		    color: #374151;
		    font-size: 14px;
		    transition: all 0.2s ease;
		}
		
		/* Default hover */
		.pagination a:hover {
		    background: #f3f4f6;
		    border-color: #9ca3af;
		}
		
		/* Active page */
		.pagination .active {
		    background: #2563eb;
		    color: #fff;
		    border-color: #2563eb;
		    font-weight: 600;
		}
		
		/* Prev/Next buttons */
		.pagination .prev, 
		.pagination .next {
		    background: #f9fafb;
		    border: 1px solid #d1d5db;
		    font-weight: 500;
		}
		.pagination .prev:hover, 
		.pagination .next:hover {
		    background: #e5e7eb;
		    border-color: #9ca3af;
		}

        .count { color:#6b7280; font-size:13px; }
        .err { background:#fee2e2; border:1px solid #fecaca; padding:10px; color:#991b1b; border-radius:8px; margin-bottom:12px; }
    </style>
</head>
<body>
 <div class="wrap">
    <div class="topbar" style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Recent Activity</h2>
       <div class="count"><c:out value="${totalRows}"/> record<c:out value="${totalRows == 1 ? '' : 's'}"/></div>
    		
    </div>
	
    <!-- Filters -->
    <form class="filters" method="get" action="${activityUrl}">
        <div>
            <label>Type</label>
            <select name="type">
                <c:set var="selectedType" value="${empty type ? 'All' : type}" />
                <option value="All" ${selectedType == 'All' ? 'selected' : ''}>All</option>
                <c:forEach var="t" items="${fn:split('Lesson,Quiz,Assignment,Student,Admin,Certificate,Payment', ',')}">
                    <option value="${t}" ${selectedType == t ? 'selected' : ''}>${t}</option>
                </c:forEach>
            </select>
        </div>
        <div>
            <label>Search</label>
            <input type="text" name="q" placeholder="Activity or user…" value="${fn:escapeXml(q)}"/>
        </div>
        <div>
            <label>From</label>
            <input type="date" name="from" value="${from}"/>
        </div>
        <div>
            <label>To</label>
            <input type="date" name="to" value="${to}"/>
        </div>
        <div>
		<button class="btn btn-apply" type="submit">Apply</button>
		<a class="btn btn-reset" href="${activityUrl}">Reset</a>
		<a class="btn-back" href="<c:url value='/admin/dashboard'/>">Back To Dashboard</a>
        </div>
        <input type="hidden" name="page" value="1"/>
    </form>

    <!-- Table -->
    <table>
        <thead>
        <tr>
            <th style="width:52%">Activity</th>
            <th style="width:18%">User</th>
            <th style="width:14%">Type</th>
            <th style="width:16%">Timestamp</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${empty activities}">
                <tr><td colspan="4" class="empty">No activities found for the selected filters.</td></tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="a" items="${activities}">
                    <tr>
                        <td><c:out value="${a.description}"/></td>
                        <td><c:out value="${a.actor}"/></td>
                        <td><span class="badge"><c:out value="${a.type}"/></span></td>
                        <td class="muted"><c:out value="${a.timestamp}"/></td>
                    </tr>
                </c:forEach>
           </c:otherwise>
        </c:choose>
        </tbody>
    </table>
	
	
    <!-- Pagination -->
    <div class="pagination">
	    <c:choose>
	        <c:when test="${totalPages <= 1}">
	            <span>Page 1 of 1</span>
	        </c:when>
	        <c:otherwise>
	            <c:set var="start" value="${pageNum - 2 > 1 ? pageNum - 2 : 1}" />
	            <c:set var="end" value="${pageNum + 2 < totalPages ? pageNum + 2 : totalPages}" />
	
	            <c:if test="${pageNum > 1}">
	                <a class="prev" href="${activityUrl}?type=${type}&q=${fn:escapeXml(q)}&from=${from}&to=${to}&page=${pageNum-1}">⟨ Prev</a>
	            </c:if>
	
	            <c:forEach var="p" begin="${start}" end="${end}">
	                <a class="${p == pageNum ? 'active' : ''}"
	                   href="${activityUrl}?type=${type}&q=${fn:escapeXml(q)}&from=${from}&to=${to}&page=${p}">
	                    ${p}
	                </a>
	            </c:forEach>
	
	            <c:if test="${pageNum < totalPages}">
	                <a class="next" href="${activityUrl}?type=${type}&q=${fn:escapeXml(q)}&from=${from}&to=${to}&page=${pageNum+1}">Next ⟩</a>
	            </c:if>
	        </c:otherwise>
	    </c:choose>
	</div>
	
</div>
</body>
</html>
