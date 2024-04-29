
class Response:
    def __init__(self, response_id, apv_question_id, user_id, answer, comment):
        self.response_id = response_id
        self.apv_question_id = apv_question_id
        self.user_id = user_id
        self.answer = answer
        self.comment = comment

    def __str__(self):
        return f"Response(reponse_id={self.response_id}, apv_question_id={self.apv_question_id}, " \
               f"user_id={self.user_id}, answer={self.answer}, " \
               f"comment={self.comment}"
