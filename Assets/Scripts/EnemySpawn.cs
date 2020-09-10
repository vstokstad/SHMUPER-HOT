#region

using UnityEngine;

#endregion

public class EnemySpawn : MonoBehaviour {
    private const string _enemyTag = "Enemy";
    private const float _timeBetweenSpawn = 3f;
    private static Vector3 _initialPosition;
    private static Vector3 _enemyDirection;

    [SerializeField] private GameObject enemyShip;
    private GameObject[] _enemyShips;
    private float _spawnTimer = 0.5f;
    public static int NumberOfEnemies { get; set; } = 10;

    private static float PositionY => Random.Range(GameManager.CameraBounds.y, -8);

    private static float PositionX => GameManager.CameraBounds.x + 2f;


    private void Start(){
        _enemyShips = new GameObject[NumberOfEnemies];
        for (int i = 0; i < _enemyShips.Length; i++) {
            _initialPosition = new Vector3(PositionX, PositionY, 0f);
            _enemyShips[i] = Instantiate(Resources.Load(_enemyTag, typeof(GameObject)), transform, true) as GameObject;
            _enemyShips[i].transform.position = _initialPosition;
            _enemyShips[i].SetActive(false);
        }

        NumberOfEnemies -= 1;
    }

    private void Update(){
        SpawnTimer();
    }

    private void SpawnTimer(){
        _spawnTimer -= Time.deltaTime;
        if (_spawnTimer <= 0f) {
            Spawn();
            _spawnTimer = _timeBetweenSpawn;
        }
    }

    private void Spawn(){
        if (NumberOfEnemies <= 0) return;
        int i = NumberOfEnemies;
        if (i < 0 || _enemyShips.Length <= i) return;
        for (int j = NumberOfEnemies; j < _enemyShips.Length - 1; j++) {
            if (_enemyShips[j].activeSelf) continue;
            enemyShip = _enemyShips[j];
            enemyShip.SetActive(true);
            _initialPosition.x = PositionX;
            _initialPosition.y = PositionY;
            enemyShip.transform.position = _initialPosition;
            break;
        }

        NumberOfEnemies -= 1;
    }

    public static void RespawnOnDeath(GameObject enemy){
        NumberOfEnemies += 1;
        enemy.transform.position = _initialPosition;
        enemy.GetComponent<EnemyController>().enemyData.health = 2f;
    }
}