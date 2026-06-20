package controller.farmer;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import org.json.JSONObject;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class WeatherServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String city = request.getParameter("city");
        String apiKey = "YOUR_API_KEY";
        String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + apiKey + "&units=metric";
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);
            JSONObject json = new JSONObject(sb.toString());
            request.setAttribute("temp", json.getJSONObject("main").getDouble("temp"));
            request.setAttribute("humidity", json.getJSONObject("main").getDouble("humidity"));
            request.setAttribute("weather", json.getJSONArray("weather").getJSONObject(0).getString("description"));
            request.getRequestDispatcher("/farmer/weather.jsp").forward(request, response);
        } catch (Exception e) {
            response.getWriter().println("Weather data unavailable. Check API key.");
        }
    }
}
