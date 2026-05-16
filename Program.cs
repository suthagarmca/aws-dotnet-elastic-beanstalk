var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.MapGet("/", () => Results.Content("""
<!doctype html>
<html lang=\"en\">
<head>
  <meta charset=\"utf-8\" />
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
  <title>AWS .NET 10 Web App</title>
  <link rel=\"stylesheet\" href=\"/css/site.css\" />
</head>
<body>
  <main class=\"container\">
    <h1>AWS .NET 10 Web App</h1>
    <p>Deployed via AWS CodePipeline + CodeBuild to EC2.</p>
    <section class=\"sample-content\">
      <h2>Sample Content</h2>
      <p>This is sample content added for UI testing.</p>
      <ul>
        <li>Item 1: Application is running</li>
        <li>Item 2: Static CSS is loaded</li>
        <li>Item 3: Background color is red</li>
      </ul>
    </section>
  </main>
</body>
</html>
""", "text/html"));

app.Run();
