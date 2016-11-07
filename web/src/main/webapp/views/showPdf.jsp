<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Online View PDF</title>
<script type="text/javascript" src="/assets/scripts/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/scripts/jquery.media.js"></script>
<script type="text/javascript">
  $(function() {
    $('a.media').media({width:1000, height:600});
  });
</script>
</head>

<body>
<a class="media" href="${src}"></a>
</body>
</html>
