<template>
  <div class="board-wrap">
    <v-data-table
        :headers="boardHeaders"
        :items="questionBoards"
        :single-expand="singleExpand"
        :expanded.sync="expanded"
        item-key="questionNo"
        show-expand
    >

<!--      <template v-slot:[`item.title`]={item}>-->
<!--        {{ item.title == 'dfsf'? '안녕' : '아니네'}}-->
<!--      </template>-->

      <template v-slot:expanded-item="{ headers, item }">
        <td :colspan="headers.length" style="background-color: #f5f5f5">
          <div class="question-board">
            <div class="question">
              <v-row>
                <p class="mt-3 mb-5" style="color: gray">{{
                    item.boardCategory.categoryType == "ORDER_PAYMENT" ? "주문/결제문의"
                        : item.boardCategory.categoryType == "PRODUCT" ? "상품문의"
                            : item.boardCategory.categoryType == "DELIVERY" ? "배송문의"
                                : item.boardCategory.categoryType == "RETURN_CHANGE" ? "반품/교환문의"
                                    : item.boardCategory.categoryType == "TOUR" ? "양조장문의"
                                        : item.boardCategory.categoryType == "OTHER" ? "기타문의" : "카테고리오류"
                  }}</p>
              </v-row>
              <v-row>
                <v-img
                    :src="require('@/assets/board/letter-q.png')"
                    max-width="20px"
                    max-height="20px"
                    contain></v-img>
                <pre class="ml-3" style="font-family: naver2">{{ item.content }}</pre>
              </v-row>
            </div>
            <div class="comment">
              <MyPageQuestionComment :question-board="item"/>
            </div>
          </div>
        </td>
      </template>
    </v-data-table>
    <div style="float: right">
      <ButtonGreen
          @click="btnRegisterBoard"
          btn-name="문의하기">
      </ButtonGreen>
      <template>
        <v-dialog v-model="showRegisterBoard" max-width="1000">
          <register-board-form/>
        </v-dialog>
      </template>
    </div>
  </div>
</template>

<script>
import {mapActions, mapState} from "vuex";
import MyPageQuestionComment from "@/components/mypage/MyPageQuestionComment";
import RegisterBoardForm from "@/components/boards/RegisterQuestionBoardForm";

export default {
  name: "MyPageQuestionForm",
  components: {RegisterBoardForm, MyPageQuestionComment},
  data() {
    return {
      expanded: [],
      singleExpand: true,
      boardHeaders: [
        {text: '제목', value: 'title'},
        {text: '작성일', value: 'createDateTime', width: 200},
        {text: '답변상태', value: 'answerState', width: 200},
        {text: '', value: 'data-table-expand'},
      ],
      showRegisterBoard: false,
    }
  },
  methods: {
    ...mapActions([
      'reqMemberQuestionBoardFromSpring',
      'requestQuestionCommentListFromSpring'
    ]),
    btnRegisterBoard() {
      this.showRegisterBoard = true
    },
  },
  async mounted() {
    this.token = window.localStorage.getItem("userInfo");
    await this.reqMemberQuestionBoardFromSpring(this.token)
  },
  computed: {
    ...mapState([
      'questionBoards'
    ])
  }
}
</script>

<style scoped>

.board-wrap {
  width: 1000px;
  margin: 50px auto;
}

.question-board {
  margin: 30px;
}

.comment {
  margin-top: 50px;
  margin-bottom: 50px;
}

</style>