import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Dummy pages for navigation - replace with actual pages later
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String? _selectedState;
  String? _selectedCity;
  List<String> _cities = [];
  Map<String, Map<String, dynamic>>? _prices;

  // Top 20 states (example, you can adjust this list)
  final Map<String, List<String>> _statesAndCities = {
    'California': ['Los Angeles', 'San Francisco', 'San Diego', 'Sacramento'],
    'Texas': ['Houston', 'Dallas', 'Austin', 'San Antonio'],
    'Florida': ['Miami', 'Orlando', 'Tampa', 'Jacksonville'],
    'New York': ['New York City', 'Buffalo', 'Rochester', 'Syracuse'],
    'Pennsylvania': ['Philadelphia', 'Pittsburgh', 'Allentown', 'Erie'],
    'Illinois': ['Chicago', 'Aurora', 'Rockford', 'Joliet'],
    'Ohio': ['Columbus', 'Cleveland', 'Cincinnati', 'Toledo'],
    'Georgia': ['Atlanta', 'Augusta', 'Columbus', 'Savannah'],
    'North Carolina': ['Charlotte', 'Raleigh', 'Greensboro', 'Durham'],
    'Michigan': ['Detroit', 'Grand Rapids', 'Warren', 'Sterling Heights'],
    'New Jersey': ['Newark', 'Jersey City', 'Paterson', 'Elizabeth'],
    'Virginia': ['Virginia Beach', 'Norfolk', 'Chesapeake', 'Richmond'],
    'Washington': ['Seattle', 'Spokane', 'Tacoma', 'Vancouver'],
    'Arizona': ['Phoenix', 'Tucson', 'Mesa', 'Chandler'],
    'Massachusetts': ['Boston', 'Worcester', 'Springfield', 'Lowell'],
    'Tennessee': ['Nashville', 'Memphis', 'Knoxville', 'Chattanooga'],
    'Indiana': ['Indianapolis', 'Fort Wayne', 'Evansville', 'South Bend'],
    'Maryland': ['Baltimore', 'Frederick', 'Rockville', 'Gaithersburg'],
    'Missouri': ['Kansas City', 'St. Louis', 'Springfield', 'Independence'],
    'Colorado': ['Denver', 'Colorado Springs', 'Aurora', 'Fort Collins'],
  };

  void _updateCities() {
    if (_selectedState != null) {
      _cities = _statesAndCities[_selectedState] ?? [];
      _selectedCity = null; // Reset city when state changes
    } else {
      _cities = [];
      _selectedCity = null;
    }
    _prices = null; // Reset prices when state changes
  }

  void _getPrices() {
    if (_selectedCity != null) {
      // Dummy prices - REPLACE WITH ACTUAL DATA FETCHING LOGIC
      // You can change the numbers below
      _prices = {
        'Apartments': {'average': 3500, 'range_low': 1200, 'range_high': 7000},
        'Houses': {'average': 700000, 'range_low': 500000, 'range_high': 1500000},
      };
    } else {
      _prices = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Finder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Select a State:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                hint: const Text('Select State'),
                value: _selectedState,
                onChanged: (newValue) {
                  setState(() {
                    _selectedState = newValue;
                    _updateCities();
                  });
                },
                items: _statesAndCities.keys.map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text('Select a City:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                hint: const Text('Select City'),
                value: _selectedCity,
                onChanged: _cities.isEmpty
                    ? null // Disable if no cities are available
                    : (newValue) {
                        setState(() {
                          _selectedCity = newValue;
                          _prices = null; // Clear prices when city changes
                        });
                      },
                items: _cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectedCity == null
                    ? null // Disable button if no city is selected
                    : () {
                        setState(() {
                          _getPrices();
                        });
                      },
                child: const Text('Get Prices'),
              ),
              if (_prices != null) ...[
                const SizedBox(height: 20),
                const Text('Estimated Prices:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Apartments: Average - \$${_prices!['Apartments']?['average']}, Range: \$${_prices!['Apartments']?['range_low']} - \$${_prices!['Apartments']?['range_high']}'),
                Text('Houses: Average - \$${_prices!['Houses']?['average']}, Range: \$${_prices!['Houses']?['range_low']} - \$${_prices!['Houses']?['range_high']}'),
              ],
              const SizedBox(height: 30),
              const Text('Advice for Picking a House:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              // Add your advice text here
              const Text(
                'Consider the location, neighborhood safety, proximity to amenities, and your budget. Think about the size and layout that suits your needs and whether you prefer a move-in ready home or a fixer-upper. Get a home inspection to identify any potential issues.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Page2 extends StatelessWidget { const Page2({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Page 2')), body: const Center(child: Text('This is Page 2'))); } }
class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  double _dailyBudget = 0.0;
  String _advice = '';

  void _calculateBudget() {
    final double monthlyIncome = double.tryParse(_incomeController.text) ?? 0.0;
    final double monthlyExpenses = double.tryParse(_expensesController.text) ?? 0.0;

    final double remainingIncome = monthlyIncome - monthlyExpenses;
    if (remainingIncome < 0) {
      _dailyBudget = 0.0;
      _advice = 'Your expenses exceed your income. You need to reduce spending significantly or increase income.';
    } else {
      _dailyBudget = remainingIncome / 30.0; // Assuming 30 days in a month
      if (_dailyBudget > 50) {
        _advice = 'You have a healthy daily budget. Consider saving or investing some of it.';
      } else if (_dailyBudget > 20) {
        _advice = 'You have a moderate daily budget. Be mindful of your spending.';
      } else {
        _advice = 'Your daily budget is tight. Focus on essential spending.';
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Income Optimization Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Monthly Income'),
            ),
            TextField(
              controller: _expensesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Monthly Expenses'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateBudget, child: const Text('Calculate Daily Budget')),
            const SizedBox(height: 20),
            Text('Daily Spending Budget: \$${_dailyBudget.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Advice: $_advice', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  int _currentQuestionIndex = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is your primary financial goal?',
      'options': [
        'Paying off debt',
        'Saving for retirement',
        'Buying a home',
        'Building an emergency fund',
        'Investing for growth'
      ],
      'answer': null,
    },
    {
      'question': 'What is your current financial situation?',
      'options': [
        'Comfortable, with savings and investments',
        'Stable, covering expenses with some savings',
        'Living paycheck to paycheck',
        'Struggling with debt',
      ],
      'answer': null,
    },
    {
      'question': 'How much do you plan to save or invest monthly?',
      'options': [
        'More than 20% of income',
        '10% - 20% of income',
        'Less than 10% of income',
        'Nothing at the moment',
      ],
      'answer': null,
    },
    {
      'question': 'How would you describe your risk tolerance?',
      'options': [
        'High (comfortable with potential losses for higher returns)',
        'Medium (balanced approach)',
        'Low (prefer safety over high returns)',
        'Unsure',
      ],
      'answer': null,
    },
  ];

  String _advice = '';

  void _answerQuestion(int questionIndex, String answer) {
    setState(() {
      _questions[questionIndex]['answer'] = answer;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _generateAdvice();
      }
    });
  }

  void _generateAdvice() {
    // Simple advice logic based on answers - you can make this more sophisticated
    String goal = _questions[0]['answer'] ?? 'not specified';
    String situation = _questions[1]['answer'] ?? 'not specified';
    String savings = _questions[2]['answer'] ?? 'not specified';
    String risk = _questions[3]['answer'] ?? 'not specified';

    _advice = 'Based on your answers:\n';
    _advice += '- Your primary goal is: $goal\n';
    _advice += '- Your current situation is: $situation\n';
    _advice += '- Your planned savings/investments are: $savings\n';
    _advice += '- Your risk tolerance is: $risk\n\n';

    if (situation.contains('Struggling with debt') || situation.contains('Living paycheck to paycheck')) {
      _advice += 'Recommendation: Prioritize creating a budget, tracking expenses, and focusing on debt reduction.\n';
    } else if (goal.contains('Saving for retirement') || goal.contains('Investing for growth')) {
      if (savings.contains('More than 20%') || savings.contains('10% - 20%')) {
        _advice += 'Recommendation: Consider exploring investment options aligned with your risk tolerance.\n';
      } else {
        _advice += 'Recommendation: Increase your savings rate to reach your investment goals faster.\n';
      }
    } else if (goal.contains('Building an emergency fund')) {
      _advice += 'Recommendation: Focus on consistently saving to build a robust emergency fund covering 3-6 months of expenses.\n';
    } else if (goal.contains('Buying a home')) {
       _advice += 'Recommendation: Create a savings plan specifically for a down payment and closing costs. Research mortgage options.\n';
    }

    if (risk.contains('High')) {
      _advice += 'For high risk tolerance, explore growth-oriented investments like stocks or mutual funds.\n';
    } else if (risk.contains('Medium')) {
      _advice += 'A balanced portfolio with a mix of stocks and bonds might suit your medium risk tolerance.\n';
    } else if (risk.contains('Low')) {
      _advice += 'Focus on lower-risk investments like savings accounts, CDs, or conservative bond funds.\n';
    }

     if (situation.contains('Comfortable')) {
       _advice += 'Recommendation: Continue with your current strategies and consider seeking advice from a financial advisor for optimizing your portfolio.\n';
     }
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _advice = '';
      for (var question in _questions) {
        question['answer'] = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financial Advisor Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _advice.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _questions[_currentQuestionIndex]['question'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ...(_questions[_currentQuestionIndex]['options'] as List<String>).map((option) {
                    return ElevatedButton(
                      onPressed: () => _answerQuestion(_currentQuestionIndex, option),
                      child: Text(option),

                    );
                  }).toList(),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Your Personalized Advice:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(_advice, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: _resetQuiz, child: const Text('Retake Quiz')),
                  ],
                ),
              ),
      ),
    );
  }
}
class Page5 extends StatelessWidget { const Page5({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Page 5')), body: const Center(child: Text('This is Page 5'))); } }

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome ${FirebaseAuth.instance.currentUser?.email ?? 'Guest'}',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page1()),
                );
              },
              child: const Text('Go to Page 1'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
              child: const Text('Go to Page 2'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page3()),
                );
              },
              child: const Text('Go to Page 3'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page4()),
                );
              },
              child: const Text('Go to Page 4'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page5()),
                );
              },
              child: const Text('Go to Page 5'),
            ),
          ],
        ),
      ),
    );
  }
}
