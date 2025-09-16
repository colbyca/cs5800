
1. List the room capacity of the course section(s) for "Database System Concepts".
```
dsc_courses = σ title = 'Database System Concepts' (course)

π capacity, room_number, building ((dsc_courses ⨝ section) ⨝ classroom)
```

2. List the name of the student and the title of the course for each student who earned an "A" in a course.
```

```
3. List the students who do not take a course.
4. Of the instructors that teach, list the instructors who do not teach any section that has a room capacity of more than 100.
5. List the building and the maximum salary among all of the instructors that are in a department in that building.
6. For every course, list the title, course_id, semester, year and number of students that take the course (you may assume the course_id is unique but two courses may have the same title).
7. List the title of the course that has the most students taking it.
8. List the names and salaries of instructor(s) that have the highest and second highest salary.
9. List the names of the students who take courses in all of the semesters except "Summer" (you should compute the names of semesters, it could be more than just "Fall", "Spring", and "Summer").
10. (Extra credit) List the instructors that have a higher salary than everyone else in their department combined.
