
1. List the room capacity of the course section(s) for "Database System Concepts".
```
dsc_courses = σ title = 'Database System Concepts' (course)

π capacity ((dsc_courses ⨝ section) ⨝ classroom)
```

2. List the name of the student and the title of the course for each student who earned an "A" in a course.
```
π student.name, course.title (σ takes.grade = 'A' (student ⨝ takes ⨝ course))
```

3. List the students who do not take a course.
```
student - (student ⋉ takes)
```
or maybe
```
σ tot_cred = 0 (student)
```

4. Of the instructors that teach, list the instructors who do not teach any section that has a room capacity of more than 100.
```
instructors_who_teach_big_classes = π teaches.ID ((σ classroom.capacity > 100 classroom) ⨝ section ⨝ teaches)
instructors_with_no_big_classes = (π ID (teaches)) - instructors_who_teach_big_classes
π name (instructor ⨝ instructors_with_no_big_classes)
```

5. List the building and the maximum salary among all of the instructors that are in a department in that building.
```
instructors_department = instructor ⨝ department
dual_instructors_department = ρ a (instructors_department) ⨯ ρ b (instructors_department)
not_max_salaries = π a.building, a.salary (σ a.building = b.building ∧ a.salary < b.salary (dual_instructors_department))

π building, salary (instructors_department) - not_max_salaries
```
or better
```
instructors_department = instructor ⨝ department
γ building; max(salary) → max_salary (instructors_department)
```

6. For every course, list the title, course_id, semester, year and number of students that take the course (you may assume the course_id is unique but two courses may have the same title).
7. List the title of the course that has the most students taking it.
8. List the names and salaries of instructor(s) that have the highest and second highest salary.
9. List the names of the students who take courses in all of the semesters except "Summer" (you should compute the names of semesters, it could be more than just "Fall", "Spring", and "Summer").
10. (Extra credit) List the instructors that have a higher salary than everyone else in their department combined.
