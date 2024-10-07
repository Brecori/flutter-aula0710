const createTable = '''
  CREATE TABLE tasks(
    id INTEGER AUTOINCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    status INTEGER NOT NULL,
  );
''';