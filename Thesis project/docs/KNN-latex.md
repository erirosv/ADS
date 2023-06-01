## K-NN Text
The k-Nearest Neighbors (k-NN) algorithm is a popular and intuitive classification algorithm. It operates based on the principle of proximity and makes predictions by identifying the k nearest neighbors to a given data point.

In the k-NN algorithm, the first step is to define a distance metric that measures the similarity or dissimilarity between data points. Skiena recommends using metrics such as Euclidean distance or Manhattan distance, which quantifies the spatial separation between points in a feature space \cite{skiena}.

To make a prediction using the k-NN algorithm, we start by selecting a value for k, which represents the number of nearest neighbors to consider. Given a new data point, the algorithm identifies the k nearest neighbors based on the chosen distance metric.

Next, Skiena suggests considering the class labels of these k neighbors. If the majority of the neighbors belong to a particular class, the algorithm assigns that class label to the new data point \cite{skiena}.

It's important to note that the choice of the value for k can impact the algorithm's performance. A smaller value of k, such as k=1, may lead to more flexible decision boundaries but can be sensitive to noise in the data. On the other hand, a larger value of k may provide smoother decision boundaries but can potentially blur the distinctions between different classes \cite{skiena}.

The k-NN algorithm does not involve explicit model training or parameter estimation. Instead, it relies on the stored training data and computes predictions based on the proximity to these labeled instances. Therefore, it is considered a lazy learning algorithm \cite{skiena}.

## LaTex Algorithm
\begin{algorithm}
\caption{k-Nearest Neighbors (k-NN)}
\label{kNN-algorithm}
\begin{algorithmic}[1]
\REQUIRE Training dataset $D = \{(\mathbf{x}_1, y_1), (\mathbf{x}_2, y_2), ..., (\mathbf{x}_n, y_n)\}$, new data point $\mathbf{x}_{\text{new}}$, number of neighbors $k$
\ENSURE Predicted class for $\mathbf{x}_{\text{new}}$
\FOR{$i = 1$ to $n$}
\STATE Compute the distance between $\mathbf{x}_{\text{new}}$ and $\mathbf{x}_i$
\ENDFOR
\STATE Select the $k$ nearest neighbors with the smallest distances
\STATE Retrieve the class labels of the selected neighbors: $y_{\text{neighbor}}$
\STATE Assign the class label to $\mathbf{x}_{\text{new}}$ based on majority voting among the $k$ neighbors
\RETURN Predicted class for $\mathbf{x}_{\text{new}}$
\end{algorithmic}
\end{algorithm}


\begin{algorithm}
\caption{k-Nearest Neighbors (k-NN)}
\label{kNN-algorithm}
\begin{algorithmic}[1]
    \Requirde Training dataset $D = \{(\mathbf{x}_1, y_1), (\mathbf{x}_2, y_2), ..., (\mathbf{x}_n, y_n)\}$, new data point $\mathbf{x}_{\text{new}}$, number of neighbors $k$
    \Ensure Predicted class for $\mathbf{x}_{\text{new}}$
    \For{$i = 1$ to $n$}{
        \State Compute the distance between $\mathbf{x}_{\text{new}}$ and $\mathbf{x}_i$
    }
    \State  Select the $k$ nearest neighbors with the smallest distances
    \State Retrieve the class labels of the selected neighbors: $y_{\text{neighbor}}$
    \State Assign the class label to $\mathbf{x}_{\text{new}}$ based on majority voting among the $k$ neighbors 
    \Return Predicted class for $\mathbf{x}_{\text{new}}$
\end{algorithmic}
\end{algorithm}