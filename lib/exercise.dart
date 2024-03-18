import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(
      title: 'Strength Training',
      imageAsset: 'assets/strength.jpg',
      article:
          'Strength training, also known as resistance training, involves exercises that work against an opposing force or resistance, such as weights, resistance bands, or your own body weight. This type of exercise helps build muscle mass, increase bone density, and boost metabolism. Common strength training exercises include weightlifting, using resistance machines, and bodyweight exercises like push-ups and squats. Incorporating strength training into your routine can improve overall strength, tone your muscles, and support a healthy body composition. Its important to prioritize proper form and gradually increase the intensity to avoid injury. Strength training can be beneficial for people of all ages and fitness levels, and it can be tailored to individual goals and preferences. Whether youre looking to build muscle, enhance athletic performance, or improve overall fitness, strength training should be an integral part of your exercise regimen.',
    ),
    Exercise(
      title: 'Aerobics',
      imageAsset: 'assets/aerobics.jpg',
      article:
          'Aerobic exercise, or cardiovascular exercise, is any activity that raises your heart rate and breathing rate for an extended period. It improves cardiovascular health, burns calories, and can help manage weight. Examples of aerobic exercises include running, cycling, swimming, dancing, and high-intensity interval training (HIIT). Regular aerobic exercise can lower blood pressure, reduce the risk of heart disease and stroke, improve sleep, and enhance mood. Its recommended to engage in at least 150 minutes of moderate aerobic activity or 75 minutes of vigorous aerobic activity per week. Aerobic exercise can be performed at varying intensities, from low-impact activities like walking or gentle cycling to high-intensity workouts like running or kickboxing. Incorporating variety in your aerobic routine can help keep it engaging and prevent boredom. Additionally, aerobic exercise can be enjoyed both indoors and outdoors, making it accessible and adaptable to different preferences and environments.',
    ),
    Exercise(
      title: 'Calisthenics',
      imageAsset: 'assets/calisthenics.jpg',
      article:
          'Calisthenics are exercises that use your body weight as resistance to build strength, endurance, and flexibility. These exercises dont require any special equipment and can be performed anywhere. Some popular calisthenics exercises include push-ups, squats, lunges, planks, and pull-ups. Calisthenics can help improve muscular strength, cardiovascular fitness, and body composition. They are particularly useful for developing functional strength and mobility, which can benefit everyday activities and reduce the risk of injury. Calisthenics workouts can be tailored to different fitness levels by adjusting the difficulty of exercises, such as performing more challenging variations or increasing the number of repetitions. These exercises can also be combined in circuits or high-intensity interval training (HIIT) routines for added cardiovascular benefits. Additionally, calisthenics can be performed outdoors, in parks or playgrounds, adding variety and enjoyment to your workout routine.',
    ),
    Exercise(
      title: 'Yoga',
      imageAsset: 'assets/yoga.jpg',
      article:
          'Yoga is an ancient practice that combines physical postures (asanas), breathing exercises (pranayama), and meditation or relaxation techniques. It promotes flexibility, strength, balance, and mindfulness. Different styles of yoga, such as Hatha, Vinyasa, and Yin, offer varying levels of intensity and focus. Practicing yoga can improve flexibility, reduce stress and anxiety, increase muscle tone and strength, and promote better posture and balance. Its also known for its potential to enhance overall well-being and inner peace. Yoga can be practiced by people of all ages and fitness levels, as the poses can be modified to suit individual needs and abilities. Regular practice can help cultivate body awareness, mindfulness, and a sense of calm and focus. Yoga can be practiced in a studio or at home, making it accessible and convenient for those who prefer a more personal or private practice.',
    ),
    Exercise(
      title: 'Fat Loss',
      imageAsset: 'assets/fat_loss.jpg',
      article:
          'Fat loss is the process of reducing body fat percentage through a combination of diet and exercise. While there is no single exercise that specifically targets fat loss, incorporating a variety of exercises can help create a calorie deficit and promote fat loss. Cardiovascular exercises like running, cycling, and swimming can help burn calories, while strength training exercises help build and maintain muscle mass, which can boost metabolism. Additionally, high-intensity interval training (HIIT) and circuit training can be effective for fat loss by combining cardio and strength training. A balanced diet with a calorie deficit is also essential for successful fat loss. Its important to focus on creating a sustainable calorie deficit through a combination of diet and exercise, rather than attempting extreme or unhealthy measures. Incorporating various types of exercises, such as cardio, strength training, and HIIT, can help target different muscle groups and keep your workouts engaging and challenging.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue, Colors.green],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.black],
          ),
        ),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseDetailPage(
                      exercise: exercise,
                    ),
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: Image.asset(
                          exercise.imageAsset,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${exercise.article.substring(0, 100)}...',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Exercise {
  final String title;
  final String imageAsset;
  final String article;

  Exercise({
    required this.title,
    required this.imageAsset,
    required this.article,
  });
}

class ExerciseDetailPage extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailPage({
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.title),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue, Colors.green],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.black],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                exercise.imageAsset,
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  exercise.article,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExercisePage(),
  ));
}
