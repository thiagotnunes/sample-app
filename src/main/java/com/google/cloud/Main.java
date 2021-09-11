/*
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.cloud;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {

  private static final String HOST = "";
  private static final String PROJECT_ID = "my-project";
  private static final String INSTANCE_ID = "my-instance";
  private static final String DATABASE_ID = "my-database";

  public static void main(String[] args) throws SQLException {
    String host_path = "";
    if (!HOST.equals("")) {
        host_path = "//" + HOST;
    }
    final String url = String.format(
        "jdbc:cloudspanner:%s/projects/%s/instances/%s/databases/%s?dialect=postgresql",
        host_path,
        PROJECT_ID,
        INSTANCE_ID,
        DATABASE_ID
    );

    try (
        Connection connection = DriverManager.getConnection(url);
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT 1::int8")
    ) {
      while (resultSet.next()) {
        System.out.println(resultSet.getInt(1));
      }
    }
  }
}
