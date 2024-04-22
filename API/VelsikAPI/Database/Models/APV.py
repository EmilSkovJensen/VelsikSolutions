
class APV:
    def __init__(self, apv_id, company_id, start_date, end_date, questions, users):
        self.apv_id = apv_id
        self.company_id = company_id
        self.start_date = start_date
        self.end_date = end_date
        self.questions = questions
        self.users = users

    def __str__(self):
        return f"Apv(apv_id={self.apv_id}, company_id={self.company_id}, " \
               f"start_date={self.start_date}, end_date={self.end_date}, " \
               f"questions={self.questions}, users={self.users})"
