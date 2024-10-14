# ZeroBase Backend School - Mission 1

## 1. 프로젝트 개요

서울시 공공 와이파이 데이터를 활용한 웹 애플리케이션입니다.

- **API 호출**로 와이파이 데이터를 가져와 DB에 저장하고 웹에서 조회합니다.
- **북마크 기능과 그룹 관리**를 통해 사용자가 관심 있는 와이파이 정보를 관리합니다.
- **위치 조회 기록**을 저장하고 불러올 수 있습니다.

---

## 2. 구현 기능

- **와이파이 정보 조회**

  - 사용자가 위치를 입력하면 주변 20개의 와이파이 정보를 조회합니다.

- **DB 연동 및 저장**

  - MariaDB를 사용해 데이터를 저장하고 조회합니다.

- **북마크 추가/삭제 및 그룹 관리**

  - 북마크를 그룹에 추가하거나 삭제하며, 그룹을 관리할 수 있습니다.

- **위치 히스토리 저장**
  - 사용자가 조회한 위치 정보를 DB에 저장하고, 목록으로 확인할 수 있습니다.

---

## 3. 프로젝트 구조

```text
webProject/
├── src/
│   ├── main/
│   │   ├── java/com/example/webproject/
│   │   │   ├── BookmarkService.java
│   │   │   ├── BookmarkGroupService.java
│   │   │   ├── HistoryService.java
│   │   │   ├── NearbyWifiService.java
│   │   │   └── wifiApiCall.java
│   │   └── webapp/
│       ├── WEB-INF/web.xml
│       ├── index.jsp
│       ├── bookmark/
│       │   ├── bookmark.jsp
│       │   ├── bookmark-add-submit.jsp
│       │   ├── bookmark_delete.jsp
│       │   └── bookmark_delete_submit.jsp
│       ├── bookmarkGroup/
│       │   ├── bookmark-group.jsp
│       │   ├── bookmark-group-add.jsp
│       │   └── bookmark-group-delete.jsp
│       ├── wifi/
│       │   ├── load-wifi.jsp
│       │   └── info.jsp
│       └── history.jsp
├── pom.xml
└── README.md
```
