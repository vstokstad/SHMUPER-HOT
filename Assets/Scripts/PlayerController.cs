using System.Collections;
using UnityEngine;

[RequireComponent(typeof(PlayerInput), typeof(PlayerMovement), typeof(PlayerBoundaries))]
[RequireComponent(typeof(WeaponManager), typeof(WeaponController), typeof(Rigidbody))]
[RequireComponent(typeof(SphereCollider), typeof(ParticleSystem))]
public class PlayerController : MonoBehaviour {
    [SerializeField] public PlayerData playerData;
    public float killCounter;
    public bool shieldInput;
    private IEnumerator _coroutine;
    private float _playerHealth;

    private void Awake(){
        GetComponent<Rigidbody>();
        killCounter = 0f;
        _playerHealth = playerData.health;
    }

    private void Update(){
        //charges shield and boost!
        playerData.RechargeTimer();
    }

    private void OnCollisionEnter(Collision other){
        const string enemy = "Enemy";
        if (!other.collider.CompareTag(enemy)) return;
        StartCoroutine(CollisionManager(other));
    }

    private IEnumerator CollisionManager(Collision other){
        EnemyController enemyController = other.gameObject.GetComponent<EnemyController>();
        Rigidbody enemyBody = other.gameObject.GetComponent<Rigidbody>();

        TakeDamage(enemyController.crashDamage);
        Vector2 bounceOffForce = new Vector2(5f, 5f);
        enemyBody.AddForce(bounceOffForce, ForceMode.Impulse);
        yield return new WaitForSeconds(0.5f);
        enemyController.TakeDamage(playerData.crashDamage);
    }


    private void TakeDamage(float damage){
        _playerHealth = -damage;
        print("took " + damage + " damage. health is now " + _playerHealth);
        if (_playerHealth <= 0f) print("DEAD");

        //GAME OVER!
    }
}