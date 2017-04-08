{
  function buildQuestion(qtype, title, prefix, answer, suffix) {
    var result = {
      type: qtype
    };
    if (title) {
      result.title = title;
    }
    if (qtype == "I") {
      result.text = prefix;
    } else {
      result.question = prefix;
      if (suffix) {
        result.suffix = suffix;
      }
    }
    if (answer) {
      result.answer = answer;
      delete answer.type;
    }
    return result;
  }

  function cleanupText(t) {
    return t.replace(/[ \t\r\n]+/g, " ").trim();
  }
}

QuestionList
  = __* first:Question rest:(__ __+ Question)* __* {
    var questions = [first].concat(rest.map(function(e) {
      return e[2];
    }));
    return questions;
  }

Question
  = t:("::" TitleText "::")? __? q:QuestionText _? "{" _? a:FillInAnswer _? "}" s:QuestionText {
    return buildQuestion(a.type, t ? t[1] : null, q, a, s);
  }
  / t:("::" TitleText "::")? __? q:QuestionText _? "{" _? a:EndAnswer _? "}" {
    return buildQuestion(a.type, t ? t[1] : null, q, a);
  }
  / t:("::" TitleText "::")? __? q:QuestionText {
    return buildQuestion("I", t ? t[1] : null, q);
  }

FillInAnswer
  = BooleanAnswer
  / NumericAnswer
  / a:MultipleChoiceAnswer+ { return { type: "MC", choices: a }; }

EndAnswer
  = a:MatchingAnswer+ { return { type: "M", pairs: a }; }
  / FillInAnswer

BooleanAnswer "boolean answer"
  = answer:BooleanToken feedback:(_? "#" AnswerText)? {
    var result = {
      type: "TF",
      correct: answer
    };
    if (feedback) {
      result.feedback = feedback[2];
    }
    return result;
  }

BooleanToken "boolean"
  = "T"i "RUE"i? { return true; }
  / "F"i "ALSE"i? { return false; }

NumericSingleAnswer
  = answer:Number !".." tolerance:(_? ":" Number)? {
    return {
      low: answer - (tolerance ? tolerance[2] : 0),
      high: answer + (tolerance ? tolerance[2] : 0)
    };
  }
  / low:Number ".." high:Number {
    return {
      low: low,
      high: high
    };
  }

NumericMultipleChoiceAnswer
  = "=" weight:Weight? answer:NumericSingleAnswer feedback:(_? "#" AnswerText)? {
    var result = {
      low: answer.low,
      high: answer.high
    };
    if (feedback) {
      result.feedback = feedback[2];
    }
    if (weight) {
      result.weight = weight;
    };
    return result;
  }

NumericAnswer "numeric answer"
  = "#" _? a:NumericSingleAnswer {
    return {
      type: "N",
      low: a.low,
      high: a.high
    };
  }
  / "#" a:(_? NumericMultipleChoiceAnswer)+ {
    return {
      type: "NMC",
      choices: a.map(function(e) { return e[1]; })
    };
  }

Number "number"
  = "-"? [0-9]+ ("." [0-9]+)? { return parseFloat(text()); }

MatchingAnswer "matching answer"
  = "=" left:AnswerText "->" right:AnswerText {
    return {
      left: left,
      right: right
    }
  }

MultipleChoiceAnswer "multiple choice answer"
  = op:ChoiceOperator weight:Weight? answer:AnswerText feedback:(_? "#" AnswerText)? {
    var result = {
      correct: op,
      text: answer
    };
    if (feedback) {
      result.feedback = feedback[2];
    }
    if (weight) {
      result.weight = weight;
    };
    return result;
  }

ChoiceOperator
  = "=" { return true; }
  / "~" { return false; }

Weight "percent credit"
  = "%" weight:$("-"? [0-9.]+) "%" { return parseInt(weight); }

AnswerText "answer text"
  = (!"->" [^~=#}])+ { return cleanupText(text()); }

QuestionText "question text"
  = (!("{" / NewLine HorizontalWhitespace* NewLine) .)+ { return cleanupText(text()); }

TitleText "title text"
  = (!"::" .)+ { return cleanupText(text()); }

Comment "comment"
  = "//" (!(NewLine / EOF) .)* (NewLine / EOF)

NewLine "newline"
  = "\r"? "\n"

EOF "end of input"
  = !.

HorizontalWhitespace "whitespace"
  = [ \t]

_ "whitespace"
  = [ \t\r\n]+

__
  = HorizontalWhitespace* NewLine
  / HorizontalWhitespace* Comment
