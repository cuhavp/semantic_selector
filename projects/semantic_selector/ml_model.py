# -*- coding: utf-8 -*-
from gensim import corpora, models, similarities
from sklearn.linear_model import LogisticRegression
from semantic_selector import tokenizer
from semantic_selector import datasource


class LsiModel(object):

    def __init__(self, grouping=None):
        self.num_topics = 25
        self.training_data_table = 'inputs'
        self.lr_solver = 'newton-cg'
        self.lr_max_iter = 10000
        self.lr_multi_class = 'ovr'
        self.grouping = grouping

        (answers,
         grouped_labels,
         grouped_label_types) = self.__fetch_training_data()
        self.answers = answers
        self.grouped_label_types = grouped_label_types
        self.grouped_label_ids = [
                self.grouped_label_id(x) for x in grouped_labels
                ]

        dictionary = corpora.Dictionary(self.answers)
        corpus = [dictionary.doc2bow(answer) for answer in self.answers]
        lsi = models.LsiModel(corpus,
                              id2word=dictionary,
                              num_topics=self.num_topics)

        lsi_corpus_flattened = []
        for vec in lsi[corpus]:
            lsi_corpus_flattened.append(self.__sparse_to_dense(vec))

        lr = LogisticRegression(solver=self.lr_solver,
                                max_iter=self.lr_max_iter,
                                multi_class=self.lr_multi_class)
        lr.fit(X=lsi_corpus_flattened, y=self.grouped_label_ids)

        self.fitting_score = lr.score(X=lsi_corpus_flattened,
                                      y=self.grouped_label_ids)
        self.dictionary = dictionary
        self.corpus = corpus
        self.lsi = lsi
        self.lr = lr

    def inference(self, target_tag):
        input_tag_tokenizer = tokenizer.InputTagTokenizer()
        tokens = input_tag_tokenizer.get_attrs_value(target_tag)
        vec_bow = self.dictionary.doc2bow(tokens)
        vec_lsi = self.__sparse_to_dense(self.lsi[vec_bow])
        return self.lr.predict([vec_lsi])[0]

    def grouped_label_id(self, label_name):
        grouped_label_name = self.grouped_label_name(label_name)
        return self.grouped_label_types.index(grouped_label_name)

    def grouped_label_name_from_id(self, label_id):
        return self.grouped_label_types[label_id]

    def grouped_label_name(self, label_name):
        if not self.grouping:
            return label_name
        else:
            if label_name in self.grouping:
                return self.grouping[label_name]
            else:
                return label_name

    def __sparse_to_dense(self, vec):
        ret = [e[1] for e in vec]
        return ret

    def __fetch_training_data(self):
        input_tag_tokenizer = tokenizer.InputTagTokenizer()
        input_tags = datasource.InputTags()
        records = input_tags.fetch_all(self.training_data_table)
        answers = []
        labels = []
        for r in records:
            words = input_tag_tokenizer.get_attrs_value(r['html'])
            answers.append(words)
            labels.append(r['label'])
        grouped_labels = [self.grouped_label_name(l) for l in labels]
        grouped_label_types = list(set(grouped_labels))
        return (answers, labels, grouped_label_types)


if __name__ == "__main__":
    print("machine learning model")