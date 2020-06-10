/****************************************************/
/* File: parse.c                                    */
/* The parser implementation for the TINY compiler  */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "util.h"
#include "scan.h"
#include "parse.h"
#include "SYMTAB.h"

static TokenType token; /* holds current token */

/* function prototypes for recursive calls */
static TreeNode* stmt_sequence(void);
static TreeNode* statement(void);
static TreeNode* if_stmt(void);
static TreeNode* repeat_stmt(void);
static TreeNode* while_stmt(void);
static TreeNode* assign_stmt(void);
static TreeNode* read_stmt(void);
static TreeNode* write_stmt(void);
static TreeNode* writec_stmt(void);
static TreeNode* int_stmt(void);
static TreeNode* char_stmt(void);
static TreeNode* exp(void);
static TreeNode* simple_exp(void);
static TreeNode* term(void);
static TreeNode* factor(void);

static void syntaxError(const char* message)
{
    fprintf(listing, "\n>>> ");
    fprintf(listing, "Syntax error at line %d: %s", lineno, message);
    Error = TRUE;
}


static void match(TokenType expected)
{
    if (token == expected) token = getToken();
    else {
        syntaxError("unexpected token -> ");
        printToken(token, tokenString);
        fprintf(listing, "      ");
    }
}

TreeNode* stmt_sequence(void)
{
    TreeNode* t = statement();
    TreeNode* p = t;
    while ((token != ENDFILE) && (token != END) &&
        (token != ELSE) && (token != UNTIL))
    {
        TreeNode* q;
        match(SEMI);
        q = statement();
        if (q != NULL) {
            if (t == NULL) t = p = q;
            else /* now p cannot be NULL either */
            {
                p->sibling = q;
                p = q;
            }
        }
    }
    return t;
}

TreeNode* statement(void)
{
    TreeNode* t = NULL;
    switch (token) {
    case IF: t = if_stmt(); break;
    case REPEAT: t = repeat_stmt(); break;
    case ID: t = assign_stmt(); break;
    case READ: t = read_stmt(); break;
    case WRITE: t = write_stmt(); break;
    case WRITEC: t = writec_stmt(); break;
    /*add while-stmt*/
    case WHILE: t = while_stmt();break;
    case INT: t = int_stmt(); break;
    case CHAR: t = char_stmt(); break;
    default: syntaxError("unexpected token -> ");
        printToken(token, tokenString);
        token = getToken();
        break;
    } /* end case */
    return t;
}

TreeNode* int_stmt()
{
    TreeNode* t = newStmtNode(IntK);
    match(INT);
    if (t != NULL && token == ID)
    {
        t->attr.name = copyString(tokenString);
    }
    match(ID);
    match(ASSIGN);
    if (t != NULL)
    {
        t->child[0] = exp();
        t->type = Integer;
        tt_insert(t->attr.name, t->type);
    }
    return t;

}

TreeNode* char_stmt()
{
    TreeNode* t = newStmtNode(CharK);
    match(CHAR);
    if (t != NULL && token == ID)
    {
        t->attr.name = copyString(tokenString);
    }
    match(ID);
    match(ASSIGN);
    if (t != NULL)
    {
        t->child[0] = exp();
        t->type = Char;
        tt_insert(t->attr.name, t->type);
    }
    return t;
}

TreeNode* while_stmt()
{
    TreeNode* t = newStmtNode(WhileK);
    match(WHILE);
    if (t != NULL) t->child[0] = exp();
    match(DO);
    if (t != NULL) t->child[1] = stmt_sequence();
    match(END);
    return t;
}


TreeNode* if_stmt(void)
{
    TreeNode* t = newStmtNode(IfK);
    match(IF);
    if (t != NULL) t->child[0] = exp();
    match(THEN);
    if (t != NULL) t->child[1] = stmt_sequence();
    if (token == ELSE) {
        match(ELSE);
        if (t != NULL) t->child[2] = stmt_sequence();
    }
    match(END);
    return t;
}

TreeNode* repeat_stmt(void)
{
    TreeNode* t = newStmtNode(RepeatK);
    match(REPEAT);
    if (t != NULL) t->child[0] = stmt_sequence();
    match(UNTIL);
    if (t != NULL) t->child[1] = exp();
    return t;
}

TreeNode* assign_stmt(void)
{
    TreeNode* t = newStmtNode(AssignK);
    if ((t != NULL) && (token == ID))
        t->attr.name = copyString(tokenString);
    match(ID);
    match(ASSIGN);
    if (t != NULL) t->child[0] = exp();
    return t;
}

TreeNode* read_stmt(void)
{
    TreeNode* t = newStmtNode(ReadK);
    match(READ);
    if ((t != NULL) && (token == ID))
        t->attr.name = copyString(tokenString);
    match(ID);
    return t;
}

TreeNode* write_stmt(void)
{
    TreeNode* t = newStmtNode(WriteK);
    match(WRITE);
    if (t != NULL) t->child[0] = exp();
    return t;
}
TreeNode* writec_stmt()
{
    TreeNode* t = newStmtNode(WritecK);
    match(WRITEC);
    if (t != NULL) t->child[0] = exp();
    return t;
}
TreeNode* exp(void)
{
    TreeNode* t = simple_exp();
    if ((token == LT) || (token == EQ)) {
        TreeNode* p = newExpNode(OpK);
        if (p != NULL) {
            p->child[0] = t;
            p->attr.op = token;
            t = p;
        }
        match(token);
        if (t != NULL)
            t->child[1] = simple_exp();
    }
    return t;
}

//识别算术表达式 a+b， a-b
TreeNode* simple_exp(void)
{
    TreeNode* t = term();
    while ((token == PLUS) || (token == MINUS))
    {
        TreeNode* p = newExpNode(OpK);
        if (p != NULL) {
            p->child[0] = t;
            p->attr.op = token;
            t = p;
            match(token);
            t->child[1] = term();
        }
    }
    return t;
}

TreeNode* term(void)
{
    TreeNode* t = factor();
    while ((token == TIMES) || (token == OVER))
    {
        TreeNode* p = newExpNode(OpK);
        if (p != NULL) {
            p->child[0] = t;
            p->attr.op = token;
            t = p;
            match(token);
            p->child[1] = factor();
        }
    }
    return t;
}

TreeNode* factor(void)
{
    TreeNode* t = NULL;
    switch (token) {
    case NUM:
        t = newExpNode(ConstK);
        if ((t != NULL) && (token == NUM))
        {
	        t->attr.val = atoi(tokenString);
            t->type = Integer;
        }   
        match(NUM);
        break;
    case ID:
        t = newExpNode(IdK);
        if ((t != NULL) && (token == ID))
            t->attr.name = copyString(tokenString);
        match(ID);
        break;
    case LPAREN:
        match(LPAREN);
        t = exp();
        match(RPAREN);
        break;
    case QUOT:
        match(QUOT);
        t = newExpNode(ConstK);
        if (t != NULL && token == ID)
        {
            t->attr.val = (int)copyString(tokenString)[0];
            t->type = Char;
        }
        match(ID);
        match(QUOT);
        break;
    default:
        syntaxError("unexpected token -> ");
        printToken(token, tokenString);
        token = getToken();
        break;
    }
    return t;
}

/****************************************/
/* the primary function of the parser   */
/****************************************/
/* Function parse returns the newly
 * constructed syntax tree
 */
TreeNode* parse(void)
{
    TreeNode* t;
    token = getToken();
    t = stmt_sequence();
    if (token != ENDFILE)
        syntaxError("Code ends before file\n");
    return t;
}
