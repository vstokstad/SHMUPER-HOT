using UnityEngine;

public class EnemySpawn : MonoBehaviour {
    private const string _enemyTag = "Enemy";
    [SerializeField] private int numberOfEnemies = 10;
    [SerializeField] private GameObject enemyShip;
    private float _timeBetweenSpawn = 2f;
    private float _spawnTimer = 3f;
    private GameObject[] _enemyShips;

    private static Vector3 InitialPosition { get; set; }

    private float MoveSpeed {
        get => enemyShip.GetComponent<EnemyController>().enemyData.moveSpeed;
        set { }
    }

    private Vector3 _enemyDirection;
    private Vector3 _playerPosition;

    private void Awake(){
        InitialPosition = new Vector3(GameManager.CameraBounds.x+1, GameManager.CameraBounds.y, 0f);
        _enemyShips = new GameObject[numberOfEnemies];
        _playerPosition = GameObject.FindWithTag("Player").transform.position;

        for (int i = 0; i < _enemyShips.Length; i++) {
            _enemyShips[i] = Instantiate(Resources.Load(_enemyTag, typeof(GameObject))) as GameObject;
            _enemyShips[i].SetActive(false);
        }

        _enemyDirection = transform.position - _playerPosition;
        numberOfEnemies -= 1;
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
        if (numberOfEnemies < 0) return;
        int i = numberOfEnemies;
        if (i >= 0 && _enemyShips.Length > i) {
            enemyShip = _enemyShips[i];
            Vector3 transformLocalPosition = InitialPosition;
            transformLocalPosition.z = 0f;
            enemyShip.transform.localPosition = transformLocalPosition;
              
            enemyShip.transform.position = transformLocalPosition;
            enemyShip.SetActive(true);
           
            Rigidbody rigidBody = enemyShip.GetComponent<Rigidbody>();
            rigidBody.MovePosition(_enemyDirection * Time.deltaTime);
            numberOfEnemies -= 1;
        }
    }
    public static void RespawnOnDeath(GameObject enemy){
        enemy.transform.position = InitialPosition;
        enemy.GetComponent<MeshRenderer>().material.color = Color.yellow;
        enemy.SetActive(true);
    }
}