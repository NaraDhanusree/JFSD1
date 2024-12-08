<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Materials</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fb;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #00796b;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .actions {
            text-align: center;
        }

        .download-button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .download-button:hover {
            background-color: #45a049;
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #2c3e50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .back-button:hover {
            background-color: #34495e;
        }
    </style>
</head>
<body>
    <h1>View Materials</h1>

    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Upload Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Lecture Notes 1</td>
                <td>Introduction to the course.</td>
                <td>2024-12-01</td>
                <td class="actions">
                    <a href="materials/lecture1.pdf" class="download-button" download>Download</a>
                </td>
            </tr>
            <tr>
                <td>Assignment Guide</td>
                <td>Instructions for the first assignment.</td>
                <td>2024-12-10</td>
                <td class="actions">
                    <a href="materials/assignment-guide.pdf" class="download-button" download>Download</a>
                </td>
            </tr>
            <tr>
                <td>Project Requirements</td>
                <td>Details on the final project requirements.</td>
                <td>2024-12-01</td>
                <td class="actions">
                    <a href="materials/project-requirements.pdf" class="download-button" download>Download</a>
                </td>
            </tr>
        </tbody>
    </table>

    <a href="ControlPanel.jsp" class="back-button">Back to Control Panel</a>
</body>
</html>
