import java.io.*;
import java.net.*;

public class WifiTest {
    private static final String API_URL = "http://openapi.seoul.go.kr:8088";
    private static final String API_KEY = "796e5945436373683838554f6b6970";

    public static void main(String[] args) {
        try{
            String requestUrl = API_URL + "/" + API_KEY + "/json/TbPublicWifiInfo/1/20/";
            URL url = new URL(requestUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }

            in.close();
            conn.disconnect();

            System.out.println(content.toString());
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
