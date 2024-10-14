package com.example.webproject;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class wifiApiCall {
    // API 정보
    private static final String API_URL = "http://openapi.seoul.go.kr:8088";
    private static final String API_KEY = "796e5945436373683838554f6b6970";

    private static int getPageNums() {
        int totalCount = 0;

        try {
            String firstURL = API_URL + "/" + API_KEY + "/json/TbPublicWifiInfo/1/1/";
            URL url = new URL(firstURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder content = new StringBuilder();
            String inputLine;

            while ((inputLine = br.readLine()) != null) {
                content.append(inputLine);
            }

            br.close();
            conn.disconnect();

            JSONObject jsonObject = new JSONObject(content.toString());
            JSONObject wifiData = jsonObject.getJSONObject("TbPublicWifiInfo");
            totalCount = wifiData.getInt("list_total_count");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalCount;
    }

    public int callApi() {
        int totalCount = 0;
        int savedCount = 0;
        int start = 1;
        int end = 1000;

        try {
            totalCount = getPageNums();
            HttpURLConnection conn;
            BufferedReader br;
            StringBuilder content;
            DBManager dbManager = new DBManager();

            while (start <= totalCount) {
                String urlMerge = API_URL + "/" + API_KEY + "/json/TbPublicWifiInfo/" + start + "/" + end + "/";
                URL url = new URL(urlMerge);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");

                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                content = new StringBuilder();
                String inputLine;

                while ((inputLine = br.readLine()) != null) {
                    content.append(inputLine);
                }

                br.close();
                conn.disconnect();

                savedCount += dbManager.saveDataToDB(content.toString());

                start = end + 1;
                end = Math.min(start + 999, totalCount);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new DBManager().getTotalWifiCount();
    }

    public static void main(String[] args) {
        wifiApiCall call = new wifiApiCall();
        call.callApi();
    }
}
